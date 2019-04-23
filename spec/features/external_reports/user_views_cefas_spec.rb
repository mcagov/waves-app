require "rails_helper"

describe "User views CEFAS reports", js: true, run_delayed_jobs: true do
  before do
    login_to_reports
    visit admin_report_path(:cefas)
  end

  scenario "in general" do
    find("#filter_date_start").set("01/01/2017")
    find("#filter_date_end").set("31/03/2017")

    expect_link_to_export_or_print(false)
    click_on("Apply Filter")

    within("#results") { click_on("Download") }

    expect(page.text).to match("You will shortly receive an email")

    downloadable_report = DownloadableReport.last

    expect(downloadable_report.file_file_name).to eq("open-registrations.xls")

    expect(last_email_sent).to have_subject("Waves: Report is ready")

    email = open_email(User.last.email)

    download_link =
      "http://test.local/admin/reports/#{downloadable_report.id}/download"

    expect(email.default_part_body)
      .to have_link("Download Report", download_link)
  end
end
