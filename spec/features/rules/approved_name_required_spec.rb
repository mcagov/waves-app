require "rails_helper"

describe "Approved name required" do
  scenario "part_1: without a registered vessel" do
    visit_claimed_task(submission: create(:submission, part: :part_1))

    expect_task_to_be_active
    expect_application_info_panel
    expect_application_tasks_panel
    expect_task_actions

    expect(page).to have_text(name_approval_process)
  end

  scenario "part_1: with a registered vessel" do
    visit_claimed_task(
      submission: create(:submission, :part_1_vessel),
      service: create(:demo_service))

    expect_task_to_be_active
    expect_application_info_panel
    expect_application_tasks_panel
    expect_task_actions

    expect(page).not_to have_text(name_approval_process)
  end

  scenario "part_3" do
    visit_claimed_task

    expect_task_to_be_active
    expect_application_info_panel
    expect_application_tasks_panel
    expect_task_actions

    expect(page).not_to have_text(name_approval_process)
  end
end

def name_approval_process
  "Name Approval Process"
end
