class FakeSmsMailer < ApplicationMailer
  default from: ENV.fetch("EMAIL_FROM")

  def send_otp(email, otp)
    @otp = otp
    mail(to: email,
         subject: "Waves Fake SMS service",
         body: "#{otp} is your UK Ship Register access code",
         layout: false)
  end
end
