require "rails_helper"

describe "Uer views MAIB reports", js: true do
  before do
    login_to_reports
    visit admin_report_path(:maib)

    find("#filter_date_start").set("01/01/2017")
    find("#filter_date_end").set("31/03/2017")
    click_on("Apply Filter")
  end

  xscenario "Quarterly Report" do
    within("#results") do
      click_on("Download", match: :last)
    end
  end
end
