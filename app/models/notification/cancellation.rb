class Notification::Cancellation < Notification
  REASONS =
    ["Cancelled by Applicant", "Rejected (by RSS)"].freeze

  def email_template
    :wysiwyg
  end

  def additional_params
    [body, actioned_by]
  end

  def email_subject
    "Application Cancelled: #{vessel_name}"
  end

  private

  def vessel_name
    notifiable.vessel.name if notifiable.vessel
  end
end
