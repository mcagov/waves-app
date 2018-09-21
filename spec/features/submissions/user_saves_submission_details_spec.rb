require "rails_helper"

describe "User saves submission details" do
  scenario "part_1" do
    visit_claimed_task(
      submission: create(:submission, :part_1_vessel))

    click_on("Save Details")
  end

  scenario "part_3" do
    visit_claimed_task

    click_on("Edit Application")
    click_on("Save Application")
  end
end
