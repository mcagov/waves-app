class DownloadableReport < ActiveRecord::Base
  belongs_to :user
  has_attached_file :file, validate_media_type: false
  do_not_validate_attachment_file_type :file

  class << self
    def build_and_notify(user, report)
      downloadable_report = create(file: build_file(report), user: user)

      ReportMailer.download_link(
        user.email, downloadable_report.download_link).deliver

      downloadable_report
    end

    private

    def build_file(report)
      FakeFile.new(
        "#{report.title.parameterize}.xls",
        ApplicationController.render(
          template: "admin/reports/show.xls",
          layout: false,
          assigns: { report: report }))
    end
  end

  def download_link
    file.expiring_url(10.minutes.since, :original)
  end
end
