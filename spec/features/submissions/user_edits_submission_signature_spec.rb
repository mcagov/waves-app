require "rails_helper"

describe "User edits submission signature" do
  before do
    create(:registered_vessel, reg_no: "SSR200001")
    visit_assigned_submission
    click_on("New Registration ID: ")
  end

  scenario "toggling the task type and checking registry_info" do
    select("Change of Vessel details", from: "Application Type")
    fill_in("Official No.", with: "SSR200001")
    click_on("Save")

    expect(Submission.last.registry_info["vessel_info"]).to be_present
    click_on("Change of Vessel details ID")

    select("New Registration", from: "Application Type")
    fill_in("Official No.", with: "SSR200001")
    click_on("Save")

    expect(Submission.last.registry_info).to be_blank
  end

  scenario "changing the part of the registry" do
    select("Part I", from: "Part of the Register")
    click_on("Save")

    expect(page).to have_text("The application has been moved to Part I")
    expect(Submission.last.registry_info).to be_blank
    expect(Submission.last).to be_unassigned
  end
end
