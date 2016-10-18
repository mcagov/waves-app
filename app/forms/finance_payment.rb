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
end
