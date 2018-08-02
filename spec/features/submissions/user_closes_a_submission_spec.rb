require "rails_helper"

describe "User close a submission", js: true do
  before do
    login_to_part_3
    visit submission_path(submission)
    click_on("Application Manager")
  end

  context "when the submission has no active tasks" do
    let(:submission) { create(:completed_submission_task).submission }

    scenario "the submission can be closed" do
      page.accept_confirm { click_on(close_application_link_text) }
      expect(page).to have_text("The application has been closed")
      expect(page).to have_current_path(tasks_my_tasks_path)

      visit(closed_submissions_path)
      click_on("Boaty McBoatface")

      expect(page).to have_css("#prompt", text: "closed on ")
    end
  end

  context "when the submission has active tasks" do
    let(:submission) { create(:claimed_task).submission }

    scenario "the close button is hidden" do
      expect(page).not_to have_link(close_application_link_text)
    end
  end
end

def close_application_link_text
  "Close Application"
end
