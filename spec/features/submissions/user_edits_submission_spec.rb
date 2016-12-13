require "rails_helper"

describe "User edits a submission", js: true do
  before do
    visit_assigned_submission
    click_on "Edit Application"
  end

  scenario "vessel and applicant details" do
    fill_in("Vessel Name", with: "BOAT")
    fill_in("Applicant Name", with: "ANNIE")
    fill_in("Applicant's Email", with: "annie@example.com")
    click_on("Save Application")

    expect(page).to have_css(".vessel-name", text: "BOAT")
    expect(page).to have_css(".applicant-name", text: "ANNIE")
    expect(page).to have_css(".applicant-email", text: "annie@example.com")
  end

  scenario "owners"
end
