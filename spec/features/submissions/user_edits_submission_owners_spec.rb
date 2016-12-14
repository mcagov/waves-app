require "rails_helper"

describe "User edits submission owners", js: true do
  before do
    visit_assigned_submission
    click_on "Edit Application"
  end

  scenario "adding an owner" do
    click_on("Owners")
    click_on("Add Individual Owner")

    fill_in("Owner Name", with: "ALICE")
    choose("FRANCE", from: "Nationality")
    fill_in("Email", with: "alice@example.com")
    fill_in("Phone Number", with: "012345678")

  end
end
