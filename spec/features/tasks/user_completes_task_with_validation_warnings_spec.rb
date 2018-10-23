require "rails_helper"

describe "User completes task with validation_warnings", js: true do
  before do
    submission =
      create(:submission, mortgages: [create(:mortgage, :registered)])

    visit_claimed_task(
      service: create(:service, rules: [:prompt_if_registered_mortgage]),
      submission: submission)
    click_on("Complete Task")
  end

  scenario "accepting the warnings before completing the task" do
    within(".modal.fade.in") do
      expect(page).to have_css(".red", text: "mortgage for this vessel")
      click_on("Accept")
      click_on("Complete Task")
    end
    wait_for_ajax
    expect(page).to have_text(completed_msg)
  end

  scenario "cancelling the warnings" do
    within(".modal.fade.in") do
      expect(page).to have_css(".red", text: "mortgage for this vessel")
      click_on("Cancel")
    end
    expect(page).not_to have_text(completed_msg)
  end
end

def completed_msg
  "The task has been completed"
end
