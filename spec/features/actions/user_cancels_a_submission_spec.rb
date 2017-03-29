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

    click_on(@submission.vessel.name)

    within("#prompt") do
      expect(page).to have_text(
        /Application Cancelled by.*: Rejected \(by RSS\)/
      )
    end

    click_on "Revert Cancellation"

    click_on "My Tasks"
    expect(page)
      .to have_css(".vessel-name", text: @submission.vessel.name)
  end
end
