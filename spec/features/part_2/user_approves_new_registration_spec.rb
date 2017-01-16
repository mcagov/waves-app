require "rails_helper"

describe "User approves new registration", js: :true do
  scenario "in general" do
    visit_name_approved_part_2_submission

    click_on("Complete Registration")
    within(".modal-content") { click_button("Register Vessel") }

    expect(page).to have_text("registered on Part II of the UK Ship Register")
  end
end
