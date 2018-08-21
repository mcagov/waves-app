require "rails_helper"

describe "User completes a task", js: true do
  scenario "in general" do
    service =
      create(:demo_service,
             activities: [:perform_a_given_task],
             print_templates: [:cover_letter])

    visit_claimed_task(service: service)

    within("#actions") { click_on("Complete Task") }

    within("#task-activities") do
      expect(page).to have_text("Perform a given task")
    end

    within("#task-print-templates") do
      expect(page).to have_text("Cover letter")
    end

    within(".modal.fade.in") { click_on "Complete Task" }

    expect(page).to have_text("The task has been completed")
    expect(@task.reload).to be_completed

    creates_a_work_log_entry("Submission::Task", :completed)
  end

  scenario "when the task has validation errors" do
    visit_claimed_task(
      submission: create(:submission, part: :part_1, correspondent_id: nil),
      service: create(:demo_service, :validates_on_approval))

    within("#actions") { click_on("Complete Task") }

    within("#task-validation-errors") do
      expect(page).to have_text("correspondent is required")
    end
  end
end
