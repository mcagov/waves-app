require "rails_helper"

describe "User edits submission for other tasks", js: true do
  scenario "for a change_address" do
    submission = create(:assigned_change_address_submission)
    login_to_part_3(submission.claimant)
    visit edit_submission_path(submission)

    expect(page).to have_css("#vessel_tab fieldset[disabled]")

    click_on("Owners")
    expect(page).not_to have_link("Remove")
    expect(page).not_to have_link("Add Individual Owner")

    click_on("Save Application")
    expect(page).to have_current_path(submission_path(Submission.last))
  end
end
