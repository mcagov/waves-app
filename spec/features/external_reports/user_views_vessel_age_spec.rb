require "rails_helper"

describe "User views Vessel Age reports", js: true do
  before do
    create(:registered_vessel, vessel_type: "BARGE")
    login_to_reports
    visit admin_report_path(:fishing_regional)
    click_on("Vessel Age")
  end

  scenario "in general" do
    expect_filter_fields(true)
    expect_link_to_export_or_print(true)

    within("#results") { expect(page).to have_button("BARGE") }
  end
end
