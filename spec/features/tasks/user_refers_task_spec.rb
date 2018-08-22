require "rails_helper"

feature "User refers a task", type: :feature, js: true do
  scenario "and restores it" do
    visit_claimed_task
    @vessel_name = @submission.vessel.name

    expect_referral_button(true)

    within("#actions") { click_on "Refer Task" }

    within(".modal.fade.in") do
      fill_in "Due By", with: "12/12/2020"
      select "Unknown vessel type", from: "Reason for Referral"

      find("#refer_modal_trix_input_notification", visible: false)
        .set("Referred!")

      click_on "Refer Task"
    end

    click_on "Referred Tasks"
    expect(Notification::Referral.last.body).to have_text("Referred!")
    creates_a_work_log_entry("Submission::Task", :referred)

    click_on @vessel_name

    within(".breadcrumb") do
      expect(page).to have_link("Referred Tasks", href: tasks_referred_path)
    end

    within("#prompt") do
      expect(page)
        .to have_text(%r{Task Referred.* Next action due by 12\/12\/2020\.})
    end

    click_button "Reclaim Referral"
    click_on "My Tasks"
    click_on @vessel_name
    click_on "Correspondence"

    within("#notification-list") do
      first(
        "a", text: "Application Referred - Action Required").click
    end

    expect(page).to have_css("h4", text: "Referral Email")

    creates_a_work_log_entry("Submission::Task", :referral_reclaimed)
  end

  scenario "without sending an email" do
    visit_claimed_task
    within("#actions") { click_on "Refer Task" }
    uncheck("Send a referral email to #{@submission.applicant.email}")
    within("#refer-task") { click_on "Refer Task" }
    expect(Notification::Referral.count).to eq(0)
  end

  scenario "without an applicant" do
    visit_claimed_task
    within("#summary") { click_on(Submission.last.applicant_name) }
    fill_in("Email Recipient Name", with: "")
    click_on("Save Notification Recipient")

    within("#actions") { click_on "Refer Task" }
    expect(page).to have_text("email cannot be sent without an Email Recipient")
    within("#refer-task") { click_on "Refer Task" }
    expect(Notification::Referral.count).to eq(0)
  end
end
