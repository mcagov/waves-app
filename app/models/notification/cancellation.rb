class Notification::Cancellation < Notification
  REASONS = [
    :owner_request,
    :no_response_from_owner].freeze

  def email_template
    :wysiwyg
  end

  def additional_params
    body
  end

  def email_subject
    "Application Cancelled"
  end
end
