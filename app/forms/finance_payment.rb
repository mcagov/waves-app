class FinancePayment
  include ActiveModel::Model

  attr_accessor(
    :part,
    :task,
    :vessel_reg_no,
    :vessel_name,
    :service_level,
    :payment_type,
    :payment_amount,
    :receipt_no,
    :applicant_name,
    :applicant_email,
    :documents_received
  )

  def create_submission
    @finance_payment = Payment.create(
      amount: payment_amount,
      submission: build_submission
    )
    @finance_payment.submission
  end

  private

  def build_submission
    Submission.new(
      part: part,
      task: task,
      source: :manual_entry,
      is_urgent: (service_level != :standard),
      changeset: build_changeset
    )
  end

  def build_changeset
    {
      vessel_info: build_vessel,
      declarations: [applicant_email],
      owners: build_owners,
      documents_received: documents_received,
      receipt_no: receipt_no,
      payment_type: payment_type,
    }
  end

  def build_vessel
    {
      name: vessel_name.blank? ? :unknown : vessel_name,
      reg_no: vessel_reg_no,
    }
  end

  def build_owners
    [
      {
        name: applicant_name,
        email: applicant_email,
      },
    ]
  end
end
