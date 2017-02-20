require "rails_helper"

describe "User sets the correspondent", js: true do
  scenario "adding an owner and setting them as correspondent" do
    visit_name_approved_part_2_submission
    click_on("Owners & Shareholding")
    click_on("Add Individual Owner")

    fill_in("Name", with: "BOB BOLD")
    click_on("Save Individual Owner")

    within("#correspondent") do
      click_on("Add Correspondent")
      select("BOB BOLD", from: "Name")
      click_on("Save Correspondent")
    end

    expect(page).to have_css(".correspondent-name", text: "BOB BOLD")
  end
end