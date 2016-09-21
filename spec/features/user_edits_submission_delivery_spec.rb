require "rails_helper"

feature "User edits Delivery Address details", type: :feature, js: true do
  scenario "in general" do
    visit_assigned_submission

    click_on("Payment")
    within("#delivery_address") do
      click_on("BOB DOLE, 11 DOWNING ST, WHITEHALL")

      within(".address-name") { click_on("BOB DOLE") }
      find(".editable-input input").set("John Doe")
      first(".editable-submit").click
      expect(page).to have_css(".address-name", text: "John Doe")

      within(".address-country") { click_on("UNITED KINGDOM") }
      find(".editable-input select").select("SPAIN")
      first(".editable-submit").click
      expect(page).to have_css(".address-country", text: "SPAIN")
    end

    delivery_address = Submission.first.delivery_address
    expect(delivery_address.name).to eq("John Doe")
    expect(delivery_address.country).to eq("SPAIN")
  end
end
