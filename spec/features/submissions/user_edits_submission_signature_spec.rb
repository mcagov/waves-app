require "rails_helper"

describe "User edits submission signature", js: true do
  before do
    submission = create(:unassigned_change_vessel_submission)
    login_to_part_3
    visit submission_path(submission)
    click_on("Change Vessel details ID: ")
  end

  scenario "changing the task type"

  scenario "changing the part of the registry"
end
