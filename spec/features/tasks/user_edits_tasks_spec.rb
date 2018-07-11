require "rails_helper"

describe "User edits tasks" do
  before do
    create(:demo_service)
    @submission = create(:assigned_submission)
    login_to_part_3(@submission.claimant)
    visit submission_tasks_path(@submission)
  end

  scenario "in general" do
    within("#services") do
      click_on("£25.00")
    end

    within("#submission_tasks") do
      expect(page).to have_css(".service_name", text: "Demo Service")
      expect(page).to have_css(".formatted_price", text: "£25.00")
      expect(page).to have_css(".ref_no", text: "/1")
    end

    within("#summary") do
      expect(page).to have_css(".payment_due", text: "£25.00")
      expect(page).to have_css(".payment_received", text: "£25.00")
      expect(page).to have_css(".balance", text: "£0.00")
    end
  end
end
