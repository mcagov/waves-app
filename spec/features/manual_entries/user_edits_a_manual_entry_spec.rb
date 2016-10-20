require "rails_helper"

describe "User edits a manual entry", type: :feature, js: true do
  before do
    create(:finance_payment, vessel_name: "MY BOAT", part: :part_3)
    login_to_part_3
    click_on("Unclaimed Tasks")
  end

  scenario "when they have claimed it" do
    click_on("Claim")
    click_on("My Tasks")
    click_on("MY BOAT")

    expect(page).to have_css("h1", "Manual Entry")

    within("#actions") do
      click_on("Convert to Application")
    end

    expect(page).to have_field("Vessel Name", with: "MY BOAT")
  end

  scenario "when they have not claimed it" do
    click_on("MY BOAT")

    expect(page).to have_css("h1", "Manual Entry")

    within("#finance_payment") do
      expect(page).to have_text("Part I")
      expect(page).to have_text("MY BOAT")
    end
  end
end
