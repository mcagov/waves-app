require "rails_helper"

feature "User views Delivery Address details", type: :feature, js: true do
  scenario "in general" do
    visit_assigned_submission

    click_on("Payment")
    within("#delivery_address") do
      expect(page).to have_text("BOB DOLE, 11 DOWNING ST, WHITEHALL")
    end
  end
end
