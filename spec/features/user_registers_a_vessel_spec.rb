require "rails_helper"

feature "User approves a new registration", type: :feature, js: true do
  before do
    visit_assigned_submission
    click_link("Register Vessel")
  end

  scenario "in its simplest form" do
    within(".modal-content") do
      click_button("Register Vessel")
    end
    expect(page).to have_text("The vessel owner has been notified via email")
  end

  scenario "attaching certificate to the email"
end
