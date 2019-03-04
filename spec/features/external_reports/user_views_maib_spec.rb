require "rails_helper"

describe "User views MAIB reports", js: true, run_delayed_jobs: true do
  before do
    login_to_reports
    visit admin_report_path(:fishing_regional)
    click_on("MAIB")

    find("#filter_date_start").set("01/01/2017")
    find("#filter_date_end").set("31/03/2017")
  end

  scenario "Registration Closures" do
    expect_link_to_export_or_print(false)

    select("Fishing Vessel Closures", from: "Report")
    click_on("Apply Filter")

    within("#results") { click_on("Download") }

    expect(page.text).to match("You will shortly receive an email")
    expect(DownloadableReport.last.file_file_name)
      .to eq("fishing-vessel-closures.xlsx")
  end

  scenario "Quarterly Report" do
    expect_link_to_export_or_print(false)

    select("Quarterly Report", from: "Report")
    click_on("Apply Filter")

    within("#results") { click_on("Download") }

    expect(page.text).to match("You will shortly receive an email")
    expect(DownloadableReport.last.file_file_name).to eq("under-12m.xlsx")
  end

  scenario "Vessel Length" do
    expect_link_to_export_or_print(false)

    select("Fishing Vessel Length", from: "Report")
    click_on("Apply Filter")

    within("#results") { click_on("Download") }

    expect(page.text).to match("You will shortly receive an email")
    expect(DownloadableReport.last.file_file_name)
      .to eq("fishing-vessel-length.xlsx")
  end
end
