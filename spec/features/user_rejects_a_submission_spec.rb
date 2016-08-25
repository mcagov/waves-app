require "rails_helper"

feature "User rejects a submission", type: :feature, js: true do
  before do
    visit_completeable_submission
  end

  scenario "and restores it" do
    within('#actions') { click_on "Reject Application" }

    select "Too Long", from: "Reason for Rejection"
    fill_in "Additional Information", with: "Some stuff"
    within('#reject-application') { click_on "Reject Application" }
  end
end
