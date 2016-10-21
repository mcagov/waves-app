require "rails_helper"

describe "User edits a submission", javascript: true do
  before do
    visit_assigned_submission
    click_on "Edit Application"
  end

  xscenario "adding an additional owner" do
    click_on "Add Individual Owner"

    fill_in("Owner Name", with: "Bob Jones")
    select("SPAIN", from: "Country of Nationality")
    fill_in("Email", with: "bob@example.com")
    fill_in("Phone Number", with: "123")

    fill_in("Address 1", with: "10 Downing St")
    fill_in("Address 2", with: "Westminster")
    fill_in("Address 3", with: "Something")
    fill_in("Town", with: "Penzance")

    click_on "Add Individual Owner"
    fill_in(".owner-name:last", with: "Alice Jones")

    click_on("Save Details")

    click_on("Owners")
    expect(page).to have_css("#declaration_1 .owner-name", text: "Bob")
    expect(page).to have_css("#declaration_2 .owner-name", text: "Alice")
  end

  scenario "removing an owner"
end
