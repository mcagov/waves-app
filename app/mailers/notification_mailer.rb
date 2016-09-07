class NotificationMailer < ApplicationMailer
  default from: ENV.fetch("EMAIL_FROM")

  def test_email(email: "test@example.com")
    mail(to: email, subject: "MCA test email service")
  end
end
