require "rails_helper"

describe "User edits top-level submission details (an edge case)" do
  before do
    @vessel = create(:registered_vessel)
    visit_assigned_submission
    find("#edit_submission_ref_no").click
  end

  scenario "when the part is not changed" do
    select("Change of Address", from: "Task Type")
    fill_in("Official Number", with: @vessel.reg_no)
    click_on("Save")

    expect(page).to have_css("h1", text: "Change of Address")

    submission = Submission.last
    expect(submission.task.to_sym).to eq(:change_address)
    expect(submission.registered_vessel).to eq(@vessel)
  end

  scenario "when the part has been changed it unassigns the submission" do
    select("Part II", from: "Part of Register")
    click_on("Save")

    expect(page).to have_css("h1", text: "My Tasks")
    expect(page).to have_text("moved to Part II")
    expect(Submission.last).to be_unassigned
  end
end
