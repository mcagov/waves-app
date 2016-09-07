# Preview all emails at http://localhost:3000/rails/mailers/notification
class NotifcationPreview < ActionMailer::Preview
  def outstanding_declaration
    NotificationMailer.outstanding_declaration(
      "email", "Alice", "foo")
  end
end
