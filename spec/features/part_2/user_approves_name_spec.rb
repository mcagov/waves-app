require "rails_helper"

feature "User approves a part 2 name", type: :feature, js: :true do
  before do
    create(:registered_vessel,
           part: :part_2,
           port_code: "SU",
           port_no: "12345",
           name: "DUPLICATE")

    login_to_part_2

    click_on("Start a New Application")
    within(".modal#start-new-application") { click_on("New Registration") }
    click_on("Save Application")
  end

  scenario "with an unavailable name" do
    fill_in("Approved Vessel Name", with: "DUPLICATE")
    select2("SOUTHAMPTON", from: "submission_name_reservation_port_code")
    fill_in("Port Number", with: "0001")
    click_on("Validate Name")

    expect(page).to have_css(
      ".reservation_name",
      text: "is not available in SOUTHAMPTON")
  end

  scenario "with an unavailable port_no" do
    fill_in("Approved Vessel Name", with: "NEW NAME")
    select2("SOUTHAMPTON", from: "submission_name_reservation_port_code")
    fill_in("Port Number", with: "12345")
    click_on("Validate Name")

    expect(page).to have_css(
      ".reservation_port-no",
      text: "is not available in SOUTHAMPTON")
  end

  scenario "with valid data" do
    fill_in("Approved Vessel Name", with: "BOBS BOAT")
    select2("Full", from: "submission_name_reservation_registration_type")
    select2("SOUTHAMPTON", from: "submission_name_reservation_port_code")
    fill_in("Port Number", with: "0001")
    fill_in("Net Tonnage", with: "10000")

    click_on("Validate Name")

    click_on("Continue")
    within(".modal-content") do
      click_on("Approve Name")
    end

    expect(page).to have_current_path(edit_submission_path(Submission.last))
  end
end
