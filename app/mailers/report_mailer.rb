class ReportMailer < ActionMailer::Base
  default from: ENV.fetch("EMAIL_FROM")

  def download_link(recipient_email, download_link)
    @download_link = download_link

    mail(to: recipient_email, subject: "Waves: Report is ready")
  end
end
