require "rails_helper"

describe "User edits top-level submission details (an edge case)" do
  before do
    visit_assigned_submission
    find("#edit_submission_ref_no").click
  end

  scenario "when the part is not changed" do
    select("Change of Address", from: "Application Type")
    fill_in("Official No.", with: "BOB")
    click_on("Save")

    expect(page).to have_css("h1", "Change of Address")
    submission = Submission.last
    expect(submission.task.to_sym).to eq(:change_address)
    expect(submission.vessel.reg_no).to eq("BOB")
  end

  scenario "when the part has been changed it unassigns the submission" do
    select("Part II", from: "Part of Register")
    click_on("Save")

    expect(page).to have_css("h1", "My Tasks")
    expect(page).to have_text("moved to Part II")
    expect(Submission.last).to be_unassigned
  end
end
