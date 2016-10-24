require "rails_helper"

describe "User edits a submission", js: true do
  before do
    visit_assigned_submission
    click_on "Edit Application"
  end

  scenario "adding an additional owner" do
    find(".owner-name").set("Alice")
    click_on "Add Individual Owner"

    all(".owner-name").last.set("Bob")
    click_on("Save Application")

    click_on("Owners")
    expect(page).to have_css("#declaration_1 .owner-name", text: "ALICE")
    expect(page).to have_css("#declaration_2 .owner-name", text: "BOB")
  end
end
