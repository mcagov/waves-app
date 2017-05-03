require "rails_helper"

feature "User views submission supporting info", type: :feature, js: true do
  let!(:submission) { create(:assigned_closure_submission) }

  before do
    login_to_part_3
    visit submission_path(submission)
  end

  xscenario "displaying the supporting info tab" do
    click_on("Supporting Info")
    expect(page).to have_css(".closure-reason", "Destroyed")
    expect(page).to have_css(".closure-description", "Viking funeral")
  end
end
