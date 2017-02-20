class Notification::ApplicationReceipt < Notification
  def email_template
    :application_receipt
  end

  def additional_params
    [vessel_name, submission_ref_no, declarations_required, notifiable.task]
  end

  def email_subject
    "Application Receipt: #{vessel_name}"
  end

  private

  def submission_ref_no
    notifiable.ref_no
  end

  def vessel_name
    notifiable.vessel_name if notifiable
  end

  def declarations_required
    if notifiable.source.to_sym == :online
      return true if notifiable.task.to_sym != :change_address
    end
    false
  end
end
