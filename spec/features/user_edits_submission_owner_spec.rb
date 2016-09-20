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

    within("#declaration_1 .owner-address") { click_on("2 Keen Road, L") }

    within(".address-1") { click_on("2 Keen") }
    find(".editable-input input").set("A 1")
    first(".editable-submit").click
    expect(page).to have_css("#declaration_1 .address-1", text: "A 1")

    within(".address-2") { click_on("Empty") }
    find(".editable-input input").set("A 2")
    first(".editable-submit").click
    expect(page).to have_css("#declaration_1 .address-2", text: "A 2")

    within(".address-3") { click_on("Empty") }
    find(".editable-input input").set("A 3")
    first(".editable-submit").click
    expect(page).to have_css("#declaration_1 .address-3", text: "A 3")

    within(".address-town") { click_on("London") }
    find(".editable-input input").set("Town")
    first(".editable-submit").click
    expect(page).to have_css("#declaration_1 .address-town", text: "Town")

    within(".address-county") { click_on("Greater London") }
    find(".editable-input input").set("County")
    first(".editable-submit").click
    expect(page).to have_css("#declaration_1 .address-county", text: "County")

    within(".address-postcode") { click_on("QZ2 3QM") }
    find(".editable-input input").set("E8")
    first(".editable-submit").click
    expect(page).to have_css("#declaration_1 .address-postcode", text: "E8")

    within(".address-country") { click_on("UNITED KINGDOM") }
    find(".editable-input select").select("SPAIN")
    first(".editable-submit").click
    expect(page).to have_css("#declaration_1 .address-country", text: "SPAIN")

    owner = Declaration.first.owner
    expect(owner.name).to eq("John Doe")
    expect(owner.email).to eq("jd@exampl.com")
    expect(owner.phone_number).to eq("999")
    expect(owner.address_1).to eq("A 1")
    expect(owner.address_2).to eq("A 2")
    expect(owner.address_3).to eq("A 3")
    expect(owner.town).to eq("Town")
    expect(owner.county).to eq("County")
    expect(owner.postcode).to eq("E8")
    expect(owner.country).to eq("SPAIN")
  end
end
