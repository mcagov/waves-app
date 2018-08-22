require "rails_helper"

describe "User sends application approval notification", js: true do
  before do
    visit_claimed_task
  end

  scenario "in general" do
    within("#application-tools") { click_on("Application Approval Email") }
    within(".modal.fade.in") { click_on("Send") }

    expect(page).to have_text("Emails have been sent")
    # expect(Notification::ApplicationApproval.count).to eq(1)
  end
end
