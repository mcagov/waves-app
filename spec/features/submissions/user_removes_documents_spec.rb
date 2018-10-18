require "rails_helper"

describe "User removes documents from a closed application", js: true do
  let!(:submission) do
    create(:closed_submission, part: part, documents: [create(:document)])
  end

  let!(:user) { create(:user) }

  before do
    create(:completed_task, submission: submission)
  end

  context "part_1" do
    let(:part) { :part_1 }

    before do
      login_to_part_1(user)
      visit submission_path(submission)
    end

    scenario "in general" do
      steps_to_remove_files
    end
  end

  context "part_3" do
    let(:part) { :part_3 }

    before do
      login_to_part_3(user)
      visit submission_path(submission)
    end

    scenario "in general" do
      steps_to_remove_files
    end
  end
end

def steps_to_remove_files
  click_on("Documents")
  within("#documents") { page.accept_confirm { click_on("Remove") } }

  click_on("Documents")
  within("#documents") do
    msg = "File removed by #{user} on #{Asset.last.updated_at}"
    expect(page).to have_css(".red", text: msg)
  end
end
