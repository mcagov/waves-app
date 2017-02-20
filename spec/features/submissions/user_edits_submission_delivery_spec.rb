require "rails_helper"

feature "User edits Delivery Address details", type: :feature, js: true do
  before do
    visit_assigned_submission
  end

  scenario "viewing and editing" do
    click_on("Payment")
    within("#delivery_address") do
      expect(page).to have_text("BOB DOLE, 11 DOWNING ST, WHITEHALL")
    end
  end
end
