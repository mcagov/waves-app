require "rails_helper"

feature "User edits Owner submission details", type: :feature, js: true do
  before { visit_assigned_submission }

  scenario "in general" do
    owner = Declaration.last.owner

    click_on("Owners")

    expect(page).to have_css("table#declaration_1 th", count: 2)

    within(".owner-name") { click_on(owner.name) }
    find(".editable-input input").set("John Doe")
    first(".editable-submit").click

    expect(page).to have_css(".owner-name", text: "JOHN DOE")

    within(".owner-email") { click_on(owner.email) }
    find(".editable-input input").set("bob@example.com")
    first(".editable-submit").click

    expect(page).to have_css(".owner-email", text: "bob@example.com")

    within(".owner-nationality") { click_on(owner.country) }
    find(".editable-input select").select("MALTA")
    first(".editable-submit").click

    expect(page).to have_css(".owner-nationality a", text: "MALTA")

    within(".owner-address") { click_on("2 KEEN ROAD, L") }
    within(".address-1") { click_on("2 KEEN") }
    find(".editable-input input").set("ADDRESS 1")
    first(".editable-submit").click

    expect(page).to have_css(".address-1", text: "ADDRESS 1")

    expect(page).to have_css(
      "a.editable-link",
      text: "ADDRESS 1, LONDON, UNITED KINGDOM, QZ2 3QM")
  end
end
