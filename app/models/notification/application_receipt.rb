class Notification::ApplicationReceipt < Notification
  def email_template
    :application_receipt
  end

  def additional_params
    [vessel_name, "", submission_ref_no]
  end

  def email_subject
    "Application Receipt: #{vessel_name}"
  end

  private

  def submission_ref_no
    notifiable.ref_no
  end

  def vessel_name
    notifiable.vessel.name if notifiable.vessel
  end
end
