require "rails_helper"

feature "User edits Owner submission details", type: :feature, js: true do
  before { visit_assigned_submission }

  scenario "in general" do
    click_on("Owners")

    within("#declaration_1 .owner-name") { click_on("Horatio Nelson") }
    find(".editable-input input").set("John Doe")
    first(".editable-submit").click

    click_on("Owners")
    expect(page).to have_css("#declaration_1 .owner-name", text: "John Doe")
  end
end
