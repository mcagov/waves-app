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

    within("#declaration_1 .owner-email") { click_on("@example.com") }
    find(".editable-input input").set("jd@exampl.com")
    first(".editable-submit").click
    click_on("Owners")
    expect(page)
      .to have_css("#declaration_1 .owner-email", text: "jd@exampl.com")

    within("#declaration_1 .owner-phone_number") { click_on("42672075807") }
    find(".editable-input input").set("999")
    first(".editable-submit").click
    click_on("Owners")
    expect(page)
      .to have_css("#declaration_1 .owner-phone_number", text: "999")

    owner = Declaration.first.owner
    expect(owner.name).to eq("John Doe")
    expect(owner.email).to eq("jd@exampl.com")
    expect(owner.phone_number).to eq("999")
  end
end
