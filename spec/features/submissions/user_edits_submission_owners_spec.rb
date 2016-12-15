require "rails_helper"

describe "User edits submission owners", js: true do
  before do
    visit_assigned_submission
    click_on "Edit Application"
    click_on("Owners")
  end

  scenario "adding an owner" do
    click_on("Owners")
    click_on("Add Individual Owner")

    fill_in("Owner Name", with: "ALICE")
    select("FRANCE", from: "Nationality")
    fill_in("Email", with: "alice@example.com")
    fill_in("Phone Number", with: "012345678")
  end

  scenario "editing an owner" do
    owner_name = Declaration.last.owner.name
    click_on(owner_name)
    expect(find_field("Owner Name").value).to eq(owner_name)
    fill_in("Owner Name", with: "ALICE")
  end
end
