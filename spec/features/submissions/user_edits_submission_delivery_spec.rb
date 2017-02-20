require "rails_helper"

feature "User edits Delivery Address details", type: :feature, js: true do
  before do
    visit_assigned_submission
  end

  scenario "viewing and editing" do
    click_on("Payment")

    expect(page).to have_css(
      "#delivery_address", text: "BOB DOLE, 11 DOWNING ST, WHITEHALL")

    click_on("Edit Application")

    within(".submission-delivery-address") do
      expect_postcode_lookup
      fill_in("Name", with: "ALICE")
      fill_in("Address 1", with: "MY HOUSE")
      fill_in("Address 2", with: "MY STREET")
      fill_in("Address 3", with: "MY OTHER STREET")
      fill_in("Town or City", with: "LONDON")
      fill_in("Postcode", with: "POC 123")
    end

    click_on("Save Application")
    click_on("Payment")
    expect(page).to have_css(
      "#delivery_address", text: "ALICE, MY HOUSE, MY STREET")
  end

  scenario "removing the delivery_address" do
    click_on("Edit Application")

    within(".submission-delivery-address") do
      fill_in("Name", with: "")
      fill_in("Address 1", with: "")
      fill_in("Postcode", with: "P")
    end

    click_on("Save Application")
    click_on("Payment")
    expect(page).not_to have_css("#delivery_address")
  end
end
