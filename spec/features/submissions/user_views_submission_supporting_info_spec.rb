require "rails_helper"

feature "User views submission supporting info", type: :feature, js: true do
  before do
    login_to_part_3
    visit submission_path(submission)
    click_on("Supporting Info")
  end

  context "closure / destroyed" do
    let!(:submission) { create(:assigned_closure_submission) }

    scenario do
      expect(page).to have_css(".closure-reason", text: "Destroyed")
      expect(page).to have_css(".closure-actioned_at", text: "23/06/2016")
      expect(page).to have_css(".closure-destruction_method", text: "BOMB")
    end
  end
end
