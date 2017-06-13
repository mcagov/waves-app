require "rails_helper"

describe "User views UK Activity reports", js: true do
  before do
    login_to_reports
    visit admin_report_path(:fishing_regional)
    click_on("UK Activity")

    find("#filter_date_start").set("01/01/2017")
    find("#filter_date_end").set("31/03/2017")
    click_on("Apply Filter")
  end

  scenario "All Merchant Flag in" do
    expect_link_to_export_or_print(true)

    within("#results") do
      expect(page).to have_button("All Merchant Flag in")
    end
  end
end
