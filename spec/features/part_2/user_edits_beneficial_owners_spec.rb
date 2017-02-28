require "rails_helper"

describe "User edits benifical owners", js: :true do
  scenario "in general" do
    visit_name_approved_part_2_submission
    click_on("Owners & Shareholding")
    click_on("Add Beneficial Owner")

    within(".modal.fade.in") do
      expect_postcode_lookup
      fill_in("Name", with: "BOB BOLD")
      fill_in("IMO Number", with: "1234567")
      select("(b)", from: "Status")
      click_on("Save Beneficial Owner")
    end

    expect(page).to have_css(".beneficial_owner-imo_number", text: "1234567")
  end
end
