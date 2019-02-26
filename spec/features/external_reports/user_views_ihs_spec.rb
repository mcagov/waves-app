require "rails_helper"

describe "User views IHS/Fairplay reports", js: true, run_delayed_jobs: true do
  before do
    login_to_reports
    visit admin_report_path(:vessel_age)
    click_on("IHS/Fairplay")
  end

  scenario "in general" do
    expect_link_to_export_or_print(false)
    within("#results") { click_on("Download") }

    expect(page.text).to match("You will shortly receive an email")
    expect(DownloadableReport.last.file_file_name).to eq("ihs-fairplay.xls")
  end
end
