class Notification::ApplicationReceipt < Notification
  def email_template
    :application_receipt
  end

  def additional_params
    [vessel_name, world_pay_transaction_no, submission_ref_no]
  end

  def email_subject
    "Application Receipt: #{vessel_name}"
  end

  private

  def world_pay_transaction_no
    notifiable.payment.remittance.wp_order_code
  end

  def submission_ref_no
    notifiable.ref_no
  end

  def vessel_name
    notifiable.vessel.name if notifiable.vessel
  end
end
