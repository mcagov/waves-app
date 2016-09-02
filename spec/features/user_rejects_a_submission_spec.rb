require "rails_helper"

feature "User rejects a submission", type: :feature, js: true do
  before do
    visit_completeable_submission
  end

  scenario "and restores it" do
    within("#actions") { click_on "Reject Application" }

    select "Too Long", from: "Reason for Rejection"
    fill_in "Additional Information", with: "Some stuff"
    within("#reject-application") { click_on "Reject Application" }

    click_on "Rejected Applications"
    click_on("Celebrator Doppelbock")

    within("#prompt") do
      expect(page).to have_text(
        /Application Rejected by.*: Too Long\. Some stuff\./
      )
    end

    click_on "Cancel Rejection"

    click_on "My Tasks"
    expect(page).to have_css(".vessel-name", text: "Celebrator Doppelbock")
  end
end
