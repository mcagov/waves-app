class Notification::ApplicationReceipt < Notification
  def email_template
    :application_receipt
  end

  def additional_params
    [world_pay_transaction_no, submission_ref_no]
  end

  private

  def world_pay_transaction_no
    notifiable.payment.wp_order_code
  end

  def submission_ref_no
    notifiable.ref_no
  end
end
