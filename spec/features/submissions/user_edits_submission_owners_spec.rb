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

    fill_in("Owner Name", with: "ALICE NEW OWNER")
    select("FRANCE", from: "Nationality")
    fill_in("Email", with: "alice@example.com")
    fill_in("Phone Number", with: "012345678")

    click_on("Save Individual Owner")
    click_on("Owners")
    expect(page).to have_link("ALICE NEW OWNER", href: "#")
  end

  scenario "editing an owner" do
    owner_name = Declaration.last.owner.name
    click_on(owner_name)

    expect(page).to have_css("input.owner-name:disabled")

    fill_in("Email", with: "@alice@example.com")
    click_on("Save Individual Owner")

    click_on("Owners")
    expect(page).to have_css(".owner-email", text: "@alice@example.com")
  end
end
