# Preview all emails at http://localhost:3000/rails/mailers/notification
class NotifcationPreview < ActionMailer::Preview
  def outstanding_declaration
    NotificationMailer.outstanding_declaration(
      "email", "Alice", "foo")
  end

  def cancellation_owner_request_with_additional_info
    NotificationMailer.cancellation_owner_request(
      "email", "Alice", "This is some additional info")
  end

  def cancellation_no_response
    NotificationMailer.cancellation_no_response(
      "email", "Alice")
  end
end
