class Notification::Cancellation < Notification
  REASONS = [
    :owner_request,
    :no_response_from_owner].freeze

  def email_template
    case subject
    when :owner_request
      :cancellation_owner_request
    when :no_reponse_from_owner
      :cancellation_no_response
    end
  end
end
