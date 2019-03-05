# Preview all emails at http://localhost:3000/rails/mailers/notification
class ReportTemplatesPreview < ActionMailer::Preview
  def downloadable_report
    ReportMailer.downloadable_report(
      "alice@example.com", DownloadableReport.create)
  end
end
