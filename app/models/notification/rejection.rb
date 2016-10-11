class Notification::Rejection < Notification
  REASONS = [
    :unsuitable_name,
    :too_long,
    :fraudulent].freeze

  def email_template
    :wysiwyg
  end

  def additional_params
    body
  end

  def email_subject
    "Application Rejected: #{vessel_name}"
  end

  private

  def vessel_name
    notifiable.vessel.name if notifiable.vessel
  end
end
