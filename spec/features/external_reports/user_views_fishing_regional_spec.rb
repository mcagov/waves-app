require "rails_helper"

describe "User views fishing regional", js: true, run_delayed_jobs: true do
  before do
    login_to_reports
    visit admin_report_path(:cefas)
    click_on("Fishing Regional")

    find("#filter_date_start").set("01/01/2017")
    find("#filter_date_end").set("31/03/2017")
    click_on("Apply Filter")
  end

  scenario "in general" do
    expect_link_to_export_or_print(false)

    within("#results") { click_on("Download") }

    expect(page.text).to match("You will shortly receive an email")
    expect(DownloadableReport.last.file_file_name)
      .to eq("fishing-regional-report.xlsx")
  end
end
