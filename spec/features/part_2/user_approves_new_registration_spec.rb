require "rails_helper"

describe "User approves new registration", js: :true do
  scenario "in general" do
    visit_name_approved_part_2_submission

    click_on("Save Details")
    click_on("Complete Registration")
    click_on("Register Vessel")

    expect(page).to have_text("registered on Part II of the UK Ship Register")
  end
end
