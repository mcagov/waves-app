require "rails_helper"

describe "User views Trinity House reports", js: true, run_delayed_jobs: true do
  before do
    login_to_reports
    visit admin_report_path(:fishing_regional)
    click_on("Trinity House")
  end

  scenario "in general" do
    find("#filter_date_start").set("01/01/2017")
    find("#filter_date_end").set("31/03/2017")

    expect_link_to_export_or_print(false)
    click_on("Apply Filter")

    within("#results") { click_on("Download") }

    expect(page.text).to match("You will shortly receive an email")
    expect(DownloadableReport.last.file_file_name).to eq("part-i.xlsx")
  end
end
