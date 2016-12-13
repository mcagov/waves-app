require "rails_helper"

describe "User edits a submission", js: true do
  before do
    visit_assigned_submission
    click_on "Edit Application"
  end

  scenario "vessel: editing" do
    fill_in("Vessel Name", with: "BOAT")
    click_on("Save Application")

    expect(page).to have_css(".vessel-name", text: "BOAT")
  end

  scenario "owners: removing Alice, then Adding Bob " do
    click_on("Owners")
    click_on("Remove Owner")
    click_on("Add Individual Owner")

    fill_in("Owner Name", with: "Bob")
    click_on("Save Application")

    click_on("Owners")
    expect(page).to have_css("#declaration_1 .owner-name", text: "BOB")
  end

  scenario "applicant: editing" do
    click_on("Applicant")
    fill_in("Applicant Name", with: "ANNIE")
    fill_in("Applicant's Email", with: "annie@example.com")
    click_on("Save Application")

    expect(page).to have_css(".applicant-name", text: "ANNIE")
    expect(page).to have_css(".applicant-email", text: "annie@example.com")
  end
end
