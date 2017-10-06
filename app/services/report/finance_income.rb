class Report::FinanceIncome < Report
  def title
    "Income Reports"
  end

  def filter_fields
    [:filter_date_range, :filter_transaction_type]
  end

  def headings
    [
      "Fee Receipt Date", "Date of Fee Entry", "Application ID", "Amount",
      "Payer Name", "Payment Type", "Revenue Stream", "Batch Identifier",
      "Application Status"
    ]
  end

  def results
    return [] unless @date_start && @date_end

    @pagination_collection = finance_payments
    @pagination_collection.map do |finance_payment|
      assign_result(finance_payment)
    end
  end

  private

  def finance_payments
    query = Payment::FinancePayment.includes(:batch)
    query = query.joins(:payment).includes(payment: :submission)
    query = query.where("payment_date BETWEEN ? AND ?", @date_start, @date_end)
    query = query.payments if payments?
    query = query.refunds if refunds?

    paginate(query.all)
  end

  def assign_result(finance_payment)
    finance_payment = Decorators::FinancePayment.new(finance_payment)

    data_elements = [
      finance_payment.payment_date, finance_payment.created_at,
      assigned_submission_for(finance_payment),
      RenderAsCurrency.new(finance_payment.payment_amount),
      finance_payment.payer_name, finance_payment.payment_type_description,
      finance_payment.part_description, finance_payment.batch_no,
      finance_payment.submission.current_state.to_s.try(:humanize)]

    Result.new(data_elements)
  end

  def payments?
    transaction_type == :payments
  end

  def refunds?
    transaction_type == :refunds
  end

  def transaction_type
    (@filters[:transaction_type] || "").to_sym
  end

  def assigned_submission_for(finance_payment)
    submission =
      if finance_payment.assigned_application_ref_no
        Submission.find_by(ref_no: finance_payment.assigned_application_ref_no)
      end

    return finance_payment.assigned_application_ref_no unless submission

    RenderAsLinkToSubmission.new(submission)
  end
end
