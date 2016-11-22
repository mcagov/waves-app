require "rails_helper"

feature "User views unclaimed task list", type: :feature, js: true do
  let!(:submission) { create(:unassigned_submission) }

  scenario "viewing the unclaimed submissions" do
    login_to_part_3
    click_link("Unclaimed Tasks")

    within("#submissions") do
      expect(page)
        .to have_css(".vessel-name", text: submission.vessel.name)
      expect(page).to have_content(submission.applicant_name)
      expect(page).to have_content("New Registration")
      expect(page).to have_css(".fa-check.i.green")
      expect(page).to have_content(submission.target_date)
      expect(page).to have_content("Online")
    end
  end

  scenario "viewing other parts of the registry" do
    login_to_part_1
    click_link("Unclaimed Tasks")

    expect(page).to have_content("There are no items in this queue")
  end
end
