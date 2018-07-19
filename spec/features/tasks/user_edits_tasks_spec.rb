require "rails_helper"

describe "User edits tasks" do
  before do
    Timecop.travel(Time.new(2016, 6, 18))
    create(:demo_service)
    @submission = create(:assigned_submission)
    login_to_part_3(@submission.claimant)
    visit submission_tasks_path(@submission)
  end

  after do
    Timecop.return
  end

  scenario "in general" do
    within("#services") do
      click_on("£25.00")
    end

    within("#submission_tasks") do
      expect(page).to have_css(".service_name", text: "Demo Service")
      expect(page).to have_css(".service_level", text: "Standard")
      expect(page).to have_css(".formatted_price", text: "25.00")
      expect(page).to have_css(".start_date", text: "18/06/2016")
      expect(page).to have_css(".state", text: "Initialising")
    end

    within("#summary") do
      expect(page).to have_css(".payment_due", text: "25.00")
      expect(page).to have_css(".payment_received", text: "25.00")
      expect(page).to have_css(".balance", text: "0.00")
    end
  end

  scenario "when the service does not exist" do
    within("#services") do
      expect(page).to have_css(".subsequent_price", text: "n/a")
    end
  end
end
