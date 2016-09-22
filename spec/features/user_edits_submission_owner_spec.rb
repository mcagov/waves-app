require "rails_helper"

feature "User edits Owner submission details", type: :feature, js: true do
  before { visit_assigned_submission }

  scenario "in general" do
    click_on("Owners")

    within(".owner-name") { click_on("Horatio Nelson") }
    find(".editable-input input").set("John Doe")
    first(".editable-submit").click
    click_on("Owners")
    expect(page).to have_css(".owner-name", text: "John Doe")

    within(".owner-nationality") { click_on("UNITED KINGDOM") }
    find(".editable-input select").select("MALTA")
    first(".editable-submit").click
    click_on("Owners")
    expect(page).to have_css(".owner-nationality a", text: "MALTA")

    within(".owner-address") { click_on("2 Keen Road, L") }

    within(".address-1") { click_on("2 Keen") }
    find(".editable-input input").set("Address 1")
    first(".editable-submit").click
    expect(page).to have_css(".address-1", text: "Address 1")

    within(".address-country") { click_on("UNITED KINGDOM") }
    find(".editable-input select").select("SPAIN")
    first(".editable-submit").click
    expect(page).to have_css(".address-country", text: "SPAIN")

    expect(page).to have_css(
      "a.editable-link", text: "Address 1, London, SPAIN, QZ2 3QM")
  end
end
