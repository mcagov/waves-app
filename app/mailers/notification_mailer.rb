class NotificationMailer < ApplicationMailer
  default from: ENV.fetch("EMAIL_FROM")

  def test_email(email)
    mail(to: email, subject: "MCA test email service")
  end
end
