class Report::FinanceIncome < Report
  def title
    "Income Reports"
  end

  def filter_fields
    [:filter_date_range, :filter_transaction_type]
  end

  def headings
    [
      "Fee Receipt Date", "Application ID", "Amount",
      "Payment Type", "Revenue Stream", "Batch Identifier"
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
    query = query.where("payment_date BETWEEN ? AND ?", @date_start, @date_end)
    query = query.payments if payments?
    query = query.refunds if refunds?

    paginate(query.all)
  end

  def assign_result(finance_payment)
    finance_payment = Decorators::FinancePayment.new(finance_payment)

    data_elements = [
      finance_payment.payment_date,
      finance_payment.assigned_application_ref_no,
      RenderAsCurrency.new(finance_payment.payment_amount),
      finance_payment.payment_type_description,
      finance_payment.part_description,
      finance_payment.batch_no]

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
end
