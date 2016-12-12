require "rails_helper"

describe "User processes a manual override", type: :feature, js: true do
  scenario "in general" do
    visit_registered_vessel

    click_on("Registrar Tools")
    click_on("Manual Override")

    expect(page).to have_css("h1", text: "Manual Override")

    click_on("Owners")
    expect(page).to have_css(".declaration", text: "n/a")

    click_on("Approve Manual Override")
    within(".modal-content") { click_button("Approve") }

    expect(page).to have_text("The Manual Override has been processed.")
  end
end
