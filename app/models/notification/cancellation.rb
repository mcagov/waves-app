class Notification::Cancellation < Notification
  REASONS = [
    :owner_request,
    :no_response_from_owner].freeze

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
