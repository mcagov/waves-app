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

    fill_in("Address 1", with: "Address 1")
    fill_in("Address 2", with: "Address 2")
    fill_in("Address 3", with: "Address 3")
    fill_in("Town or City", with: "Town")
    fill_in("Postcode", with: "POC123")

    within(".declaration_declaration_signed") { choose("Yes") }
    click_on("Save Individual Owner")

    expect(page).to have_link("ALICE NEW OWNER", href: "#")
    expect(page).to have_css(".owner-email", text: "alice@example.com")
    expect(page).to have_css(".owner-phone_number", text: "012345678")
    expect(page).to have_css(".owner-nationality", text: "FRANCE")
    expect(page)
      .to have_css(".owner-address",
                   text: "ADDRESS 1, ADDRESS 2, ADDRESS 3, TOWN, POC123")
    expect(Declaration.last).to be_completed
  end

  scenario "editing an owner" do
    owner_name = Declaration.last.owner.name
    click_on(owner_name)

    expect(page).to have_css("input.owner-name:disabled")

    fill_in("Email", with: "edited_alice@example.com")
    click_on("Save Individual Owner")

    click_on(owner_name)
    expect(find_field("Email").value).to eq("edited_alice@example.com")
  end

  scenario "removing an owner" do
    owner_name = Declaration.last.owner.name

    # insert an owner into the registry info in order
    # to test that an owner can be "removed" and displays as ".strike"
    Submission.last.update_attributes(
      registry_info: { owners: [{ name: owner_name }] })

    expect(page).to have_css(".owner-name", text: owner_name)

    page.accept_confirm { click_on("Remove") }
    expect(page).to have_css(".strike", text: owner_name)
  end
end
