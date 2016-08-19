require "rails_helper"

feature "User views dashboard", type: :feature, js: true do
  let!(:submission) { create_submission! }

  before do
    login
  end

  scenario "submissions" do
    within("#submissions") do
      expect(page).to have_content("Celebrator Doppelbock")
      expect(page).to have_content("Horatio Nelson")
      expect(page).to have_content("New Registration")
      expect(page).to have_css(".fa-times.i.red")
      expect(page).to have_content(submission.target_date)
      expect(page).to have_content(submission.source)
    end
  end
end
