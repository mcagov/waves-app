class NotificationMailer < ApplicationMailer
  default from: "notifications@example.com"

  def test_email
    mail(to: "test@example.com", subject: "MCA test email service")
  end
end
