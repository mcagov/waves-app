# Preview all emails at http://localhost:3000/rails/mailers/notification
class ReportTemplatesPreview < ActionMailer::Preview
  def downloadable_report
    ReportMailer.download_link(
      "alice@example.com", "http://localhost")
  end
end
