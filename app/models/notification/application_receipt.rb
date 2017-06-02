class Notification::ApplicationReceipt < Notification
  def email_template
    :application_receipt
  end

  def additional_params
    [vessel_name, submission_ref_no]
  end

  def email_subject
    "UK ship registry, reference no: #{submission_ref_no}"
  end

  private

  def submission_ref_no
    notifiable.ref_no
  end

  def vessel_name
    notifiable.vessel_name if notifiable
  end
end
