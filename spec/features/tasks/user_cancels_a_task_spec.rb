require "rails_helper"

feature "User cancels a task", type: :feature, js: true do
  scenario "in general" do
    visit_claimed_task
    within("#actions") { click_on "Cancel Task" }

    within(".modal.fade.in") do
      check(@submission.applicant.email_description)
      check(@submission.owners.first.email_description)
      select "Rejected (by RSS)", from: "Reason for cancelling task"
      find(".trix-content", visible: false).set("Sorry!")

      click_on "Cancel Task"
    end

    expect_task_to_be_cancelled
    expect(Notification::Cancellation.last.body).to have_text("Sorry!")
    expect(Notification::Cancellation.count).to eq(2)
  end

  scenario "without sending an email" do
    visit_claimed_task
    within("#actions") { click_on "Cancel Task" }
    within("#cancel-task") { click_on "Cancel Task" }

    expect_task_to_be_cancelled
    expect(Notification::Cancellation.count).to eq(0)
  end
end

def expect_task_to_be_cancelled # rubocop:disable Metrics/MethodLength
  click_on "Cancelled Tasks"
  click_on(@submission.vessel.name)

  within(".breadcrumb") do
    expect(page).to have_link("Cancelled Tasks", href: tasks_cancelled_path)
  end

  within("#prompt") do
    expect(page).to have_text(
      /Task Cancelled by #{@task.claimant.to_s} on .*./
    )
  end

  creates_a_work_log_entry(:task_cancelled)
  creates_a_staff_performance_entry(:cancelled)
end
