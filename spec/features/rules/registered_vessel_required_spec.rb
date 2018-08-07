require "rails_helper"

describe "Registered vessel required" do
  scenario "without a registered vessel" do
    visit_claimed_task(
      service: create(:demo_service, :registered_vessel_required))

    expect_task_to_be_active
    expect_application_info_panel
    expect_application_tasks_panel
    expect_task_actions

    expect(page).to have_text(task_cannot_be_processed)
  end

  scenario "with a registered vessel" do
    visit_claimed_task(
      submission: create(:submission, :part_3_vessel),
      service: create(:demo_service, :registered_vessel_required))

    expect_task_to_be_active
    expect_application_info_panel
    expect_application_tasks_panel
    expect_task_actions

    expect(page).not_to have_text(task_cannot_be_processed)
  end
end

def task_cannot_be_processed
  "This task cannot be processed"
end
