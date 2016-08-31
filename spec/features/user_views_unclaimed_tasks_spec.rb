require "rails_helper"

feature "User views unclaimed task list", type: :feature, js: true do
  let!(:submission) { create_paid_submission! }

  before do
    login_to_part_3
  end

  scenario "viewing the unclaimed submissions" do
    within("#submissions") do
      expect(page).to have_content("Celebrator Doppelbock")
      expect(page).to have_content("Horatio Nelson")
      expect(page).to have_content("New Registration")
      expect(page).to have_css(".fa-check.i.green")
      expect(page).to have_content(submission.target_date)
      expect(page).to have_content(submission.source)
    end
  end
end
