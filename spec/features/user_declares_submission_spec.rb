require "rails_helper"

feature "User declares a submission", type: :feature, js: true do
  let!(:submission) { create_incomplete_submission! }
  let!(:bob) { create(:user, name: "Bob") }

  before do
    login(bob)
    visit submission_path(submission)
  end

  scenario "and uploads a file" do
    click_on("Owners")
    click_on("Add manual declaration")

    within("#declaration_2 .declaration") do
      expect(page).to have_text("Completed by Bob")
    end
  end
end
