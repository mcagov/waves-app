require "rails_helper"

feature "User refers a task", type: :feature, js: true do
  scenario "and restores it" do
    visit_claimed_task

    expect_referral_button(true)

    within("#actions") { click_on "Refer Task" }

    within(".modal.fade.in") do
      check(@submission.applicant.email_description)
      check(@submission.owners.first.email_description)
      fill_in "Due By", with: "12/12/2020"
      select "Unknown vessel type", from: "Reason for Referral"

      find("#refer_modal_trix_input_notification", visible: false)
        .set("Referred!")

      click_on "Refer Task"
    end

    expect_task_to_be_referred
    expect(Notification::Referral.last.body).to have_text("Referred!")
    expect(Notification::Referral.count).to eq(2)

    click_button "Reclaim Referral"
    click_on "My Tasks"
    click_on @submission.vessel.name
    click_on "Correspondence"

    within("#notification-list") do
      first(
        "a", text: "Application Referred - Action Required").click
    end

    expect(page).to have_css("h4", text: "Referral Email")

    creates_a_work_log_entry(:referral_reclaimed)
  end

  scenario "without sending an email" do
    visit_claimed_task
    within("#actions") { click_on "Refer Task" }

    within("#refer-task") do
      fill_in "Due By", with: "12/12/2020"
      click_on "Refer Task"
    end

    expect_task_to_be_referred
    expect(Notification::Referral.count).to eq(0)
  end
end

def expect_task_to_be_referred
  click_on "Referred Tasks"
  click_on @submission.vessel.name

  within(".breadcrumb") do
    expect(page).to have_link("Referred Tasks", href: tasks_referred_path)
  end

  within("#prompt") do
    expect(page)
      .to have_text(%r{Task Referred.* Next action due by 12\/12\/2020\.})
  end

  creates_a_work_log_entry(:task_referred)
  creates_a_staff_performance_entry(:referred)
end
