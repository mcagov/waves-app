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
    fill_in("Vessel Name", with: "DUPLICATE")
    select2("SOUTHAMPTON", from: "submission_name_approval_port_code")
    fill_in("Port Number", with: "0001")
    click_on("Validate Name")

    expect(page).to have_css(
      ".approval_name",
      text: "is not available in SOUTHAMPTON")
  end

  scenario "with an unavailable port_no" do
    fill_in("Vessel Name", with: "NEW NAME")
    select2("SOUTHAMPTON", from: "submission_name_approval_port_code")
    fill_in("Port Number", with: "12345")
    click_on("Validate Name")

    expect(page).to have_css(
      ".approval_port-no",
      text: "is not available in SOUTHAMPTON")
  end

  scenario "with valid data" do
    Timecop.travel(Time.now) do
      fill_in("Vessel Name", with: "BOBS BOAT")
      select2("Full", from: "submission_name_approval_registration_type")
      select2("SOUTHAMPTON", from: "submission_name_approval_port_code")

      expect(page).to have_css(
        ".approval_port-no .form-control-feedback", text: "SU")

      fill_in("Port Number", with: "99")

      click_on("Validate Name")

      expect(page).to have_css(
        ".alert",
        text: "The name BOBS BOAT is available in SOUTHAMPTON")
      select("10 years", from: "Approved for")
      click_on("Approve Name")

      expect(page).to have_current_path(edit_submission_path(Submission.last))
      creates_a_work_log_entry("Submission", :name_approval)

      visit(submission_path(Submission.last))

      expect(page).to have_css(".vessel-name", text: "BOBS BOAT")
      expect(page).to have_css(".expiry-date", text: 10.years.from_now.to_date)
    end
  end
end
