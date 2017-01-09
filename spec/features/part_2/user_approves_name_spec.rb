require "rails_helper"

feature "User approves a part 2 name", type: :feature do
  before do
    login_to_part_2

    click_on("Start a New Application")
    within(".modal#start-new-application") { click_on("New Registration") }
    click_on("Save Application")
  end

  scenario "with an unavailable name" do
    fill_in("Approved Vessel Name", with: "DUPLICATE NAME")
    select("SOUTHAMPTON", from: "Port of Choice")
    fill_in("Port No", with: "12345")
    click_on("Validate Name")

    expect(page).to have_text("Vessel name is not available in SOUTHAMPTON")
  end

  scenario "with an unavailable port_no" do

  end

  xscenario "with valid data" do
    fill_in("Approved Vessel Name", with: "BOBS BOAT")
    select("Simple", from: "Registration Type")
    select("SOUTHAMPTON", from: "Port of Choice")
    fill_in("Port No", with: "12345")
    fill_in("Net Tonnage", with: "10000")

    click_on("Validate Name")
    click_on("Continue")
    within(".modal-content") do
      check("Send carving and marking")
      choose("Send via email automatically")
      click_button("Approve Name")
    end

    expect(page).to have_current_path(edit_submission_path(Submission.last))
  end
end
