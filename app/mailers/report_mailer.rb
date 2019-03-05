class ReportMailer < ActionMailer::Base
  default from: ENV.fetch("EMAIL_FROM")

  def downloadable_report(recipient_email, downloadable_report)
    @downloadable_report = downloadable_report

    mail(to: recipient_email, subject: "Waves: Report is ready")
  end
end
