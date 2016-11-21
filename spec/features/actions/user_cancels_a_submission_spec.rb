require "rails_helper"

feature "User cancels a submission", type: :feature, js: true do
  before do
    visit_assigned_submission
    @submission = Submission.last
  end

  scenario "and restores it" do
    within("#actions") { click_on "Cancel Application" }

    select "Rejected (by RSS)", from: "Reason for cancelling application"
    page.execute_script("tinyMCE.activeEditor.insertContent('Some stuff')")
    within("#cancel-application") { click_on "Cancel Application" }

    click_on "Cancelled Applications"
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
