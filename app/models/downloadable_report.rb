class DownloadableReport < ActiveRecord::Base
  belongs_to :user
  has_attached_file :file, validate_media_type: false
  do_not_validate_attachment_file_type :file

  class << self
    def build(user, report)
      create(file: build_file(report), user: user)
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
end
