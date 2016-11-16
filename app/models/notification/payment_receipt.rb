class Notification::PaymentReceipt < Notification
  def email_template
    :payment_receipt
  end

  def additional_params
    ["", actioned_by]
  end

  def email_subject
    "Payment Receipt"
  end
end
