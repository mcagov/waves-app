require "rails_helper"

describe "User views MAIB reports", js: true do
  before do
    login_to_reports
    visit admin_report_path(:maib)

    find("#filter_date_start").set("01/01/2017")
    find("#filter_date_end").set("31/03/2017")
    click_on("Apply Filter")

    @results = page.all("table#results tr")
  end

  scenario "Registration Closures" do
    within(@results[1]) { click_on("Download") }

    expect(page.response_headers["Content-Type"]).to match("application/xls")
    expect(page.text).to match("Worksheet ss:Name=\"Fishing Vessel Closures\"")
  end

  scenario "Quarterly Report" do
    within(@results[3]) { click_on("Download") }

    expect(page.response_headers["Content-Type"]).to match("application/xls")
    expect(page.text).to match("Worksheet ss:Name=\"Under 12m\"")
    expect(page.text).to match("Worksheet ss:Name=\"12m and over\"")
  end
end
