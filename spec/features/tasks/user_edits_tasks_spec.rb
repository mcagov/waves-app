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

  scenario "adding and confirming" do
    within("#services") do
      click_on("£25.00")
    end

    within("#submission_tasks") do
      expect(page).to have_css(".service_name", text: "Demo Service")
      expect(page).to have_css(".service_level", text: "Standard")
      expect(page).to have_css(".formatted_price", text: "25.00")
      expect(page).to have_css(".start_date", text: "18/06/2016")
    end

    click_on(confirm_tasks_link_text)

    within("#summary") do
      expect(page).to have_css(".payment_due", text: "25.00")
      expect(page).to have_css(".payment_received", text: "25.00")
      expect(page).to have_css(".balance", text: "0.00")
    end

    within("#submission_tasks") do
      expect(page).not_to have_text(confirm_tasks_link_text)
      expect(page).not_to have_text(remove_task_link_text)
    end
  end

  scenario "adding and removing" do
    within("#services") do
      click_on("£25.00")
    end

    within("#submission_tasks") do
      click_on(remove_task_link_text)
    end

    expect(Submission::Task.count).to eq(0)
  end

  scenario "when the service does not exist" do
    within("#services") do
      expect(page).to have_css(".subsequent_price", text: "n/a")
    end
  end
end

def confirm_tasks_link_text
  "Confirm Tasks"
end

def remove_task_link_text
  "Remove"
end
