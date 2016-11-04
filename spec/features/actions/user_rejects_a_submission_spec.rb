require "rails_helper"

feature "User rejects a submission", type: :feature, js: true do
  before do
    visit_assigned_submission
    @vessel_name = Submission.last.vessel.name
  end

  scenario "and restores it" do
    within("#actions") { click_on "Reject Application" }

    select "Too long", from: "Reason for Rejection"
    page.execute_script("tinyMCE.activeEditor.insertContent('Some stuff')")
    within("#reject-application") { click_on "Reject Application" }

    click_on "Rejected Applications"
    click_on(@vessel_name)

    within("#prompt") do
      expect(page).to have_text(
        /Application Rejected by.*: Too long\./
      )
    end

    click_on "Cancel Rejection"

    click_on "My Tasks"
    expect(page).to have_css(".vessel-name", text: @vessel_name)
  end
end
