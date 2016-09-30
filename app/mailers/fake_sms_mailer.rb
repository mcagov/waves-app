class FakeSmsMailer < ApplicationMailer
  default from: ENV.fetch("EMAIL_FROM")

  def send_access_code(email, access_code)
    @access_code = access_code
    mail(to: email,
         subject: "Waves Fake SMS service",
         body: "#{access_code} is your UK Ship Register access code",
         layout: false)
  end
end
