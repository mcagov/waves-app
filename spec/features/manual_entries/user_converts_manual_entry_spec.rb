require "rails_helper"

describe "User converts manual entry", type: :feature, js: true do
  before do
    create(
      :finance_payment,
      part: :part_3,
      task: :change_registry_details,
      vessel_reg_no: create(:registered_vessel, name: "MY BOAT").reg_no,
      vessel_name: "MY BOAT", applicant_name: "BOB")

    login_to_part_3
    click_on("Unclaimed Tasks")
  end

  scenario "when they have claimed it they can 'convert' it" do
    click_on("Claim")
    click_on("My Tasks")
    click_on("MY BOAT")

    expect(page).to have_css("h1", text: "Change of Registry Details")

    within("#actions") do
      click_on("Convert to Application")
    end

    expect(page).to have_css("#actions")
  end

  scenario "when they have not claimed it they can't 'convert' it" do
    click_on("MY BOAT")

    expect(page).to have_css("h1", text: "Change of Registry Details")

    within("#finance_payment") do
      expect(page).to have_text("Part I")
      expect(page).to have_text("MY BOAT")
    end
  end
end
