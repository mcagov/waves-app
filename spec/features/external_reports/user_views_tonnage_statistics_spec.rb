require "rails_helper"

describe "User views UK Tonnage Statistics report", js: true do
  before do
    login_to_reports
    visit admin_report_path(:fishing_regional)
    click_on("Tonnage Statistics")
  end

  scenario "Merchant Flag in" do
    expect_filter_fields(false)
    expect_link_to_export_or_print(true)

    within("#results") do
      expect(page)
        .to have_css("td", text: "Part I Merchant vessels under 100gt (R)")
    end
  end
end
