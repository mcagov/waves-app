require "rails_helper"

feature "User cancels a submission", type: :feature, js: true do
  before do
    visit_assigned_submission
    @submission = Submission.last
  end

  scenario "and restores it" do
    within("#actions") { click_on "Cancel Application" }

    within(".modal.fade.in") do
      select "Rejected (by RSS)", from: "Reason for cancelling application"

      find("#cancel_modal_trix_input_notification", visible: false)
        .set("Sorry!")

      click_on "Cancel Application"
    end

    click_on "Cancelled Applications"
    expect(Notification::Cancellation.last.body).to have_text("Sorry!")
    creates_a_work_log_entry("Submission", :cancellation)

    click_on(@submission.vessel.name)

    within("#prompt") do
      expect(page).to have_text(
        /Application Cancelled. Rejected \(by RSS\)/
      )
    end

    click_on "Revert Cancellation"

    click_on "My Tasks"
    expect(page)
      .to have_css(".vessel-name", text: @submission.vessel.name)
  end

  scenario "without sending an email" do
    within("#actions") { click_on "Cancel Application" }
    uncheck("Send a cancellation email to #{Submission.last.applicant_name}")
    within("#cancel-application") { click_on "Cancel Application" }
    expect(Notification::Cancellation.count).to eq(0)
  end

  scenario "without an applicant" do
    within("#summary") { click_on(Submission.last.applicant_name) }
    fill_in("Email Recipient Name", with: "")
    click_on("Save Notification Recipient")

    within("#actions") { click_on "Cancel Application" }
    expect(page).to have_text("email cannot be sent without an Email Recipient")
  end
end
