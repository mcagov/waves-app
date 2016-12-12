require "rails_helper"

describe "User processes a manual override", type: :feature, js: true do
  scenario "in general" do
    visit_registered_vessel

    click_on("Registrar Tools")
    click_on("Manual Override")

    expect(page).to have_css("h1", text: "Manual Override")

    click_on("Owners")
    expect(page).to have_css(".declaration", text: "n/a")
  end
end
