require "rails_helper"

feature "User approves a part 2 name", type: :feature, js: :true do
  before do
    create(:registered_vessel,
           part: :part_2,
           port_code: "SU",
           port_no: "12345",
           name: "DUPLICATE")

    visit_assigned_part_2_submission
  end

  scenario "with an unavailable name" do
    fill_in("Approved Vessel Name", with: "DUPLICATE")
    select2("SOUTHAMPTON", from: "submission_name_approval_port_code")
    fill_in("Port Number", with: "0001")
    click_on("Validate Name")

    expect(page).to have_css(
      ".approval_name",
      text: "is not available in SOUTHAMPTON")
  end

  scenario "with an unavailable port_no" do
    fill_in("Approved Vessel Name", with: "NEW NAME")
    select2("SOUTHAMPTON", from: "submission_name_approval_port_code")
    fill_in("Port Number", with: "12345")
    click_on("Validate Name")

    expect(page).to have_css(
      ".approval_port-no",
      text: "is not available in SOUTHAMPTON")
  end

  scenario "toggling the tonnage fields" do
    click_on("Switch to Register Tonnage")
    fill_in("Register Tonnage", with: "1234.5")
    click_on("Switch to Net Tonnage")
    fill_in("Net Tonnage", with: "6789")
  end

  scenario "with valid data" do
    fill_in("Approved Vessel Name", with: "BOBS BOAT")
    select2("Full", from: "submission_name_approval_registration_type")
    select2("SOUTHAMPTON", from: "submission_name_approval_port_code")

    expect(page).to have_css(
      ".approval_port-no .form-control-feedback", text: "SU")

    fill_in("Port Number", with: "99")
    fill_in("Net Tonnage", with: "10000")

    click_on("Validate Name")

    expect(page).to have_css(
      ".alert",
      text: "The name BOBS BOAT is available in SOUTHAMPTON")

    click_on("Continue")
    within(".modal-content") do
      click_on("Approve Name")
    end

    expect(page).to have_current_path(edit_submission_path(Submission.last))
    creates_a_work_log_entry("Submission", :name_approval)

    submission = Submission.last
    expect(submission.vessel.name).to eq("BOBS BOAT")

    vessel = submission.registered_vessel
    expect(vessel.name).to eq("BOBS BOAT")
    expect(vessel.registration_type).to eq("full")
    expect(vessel.port_code).to eq("SU")
    expect(vessel.port_no).to eq(99)
    expect(vessel.net_tonnage.to_i).to eq(10000)
  end
end
