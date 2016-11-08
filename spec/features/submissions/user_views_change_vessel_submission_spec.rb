require "rails_helper"

feature "User views change of details submission", type: :feature, js: true do
  let!(:submission) { create(:unassigned_change_registry_details_submission) }
  let!(:registered_vessel) { submission.registered_vessel }
  before do
    login_to_part_3
    visit submission_path(submission)
  end

  scenario "rendering 3 column table for vessel and owners" do
    within("h1") do
      expect(page).to have_content("Change of Registry Details ID: ")
    end

    click_link("Vessel Information")

    within("table.submission-vessel") do
      expect(page).to have_css("th", count: 3)

      expect(page)
        .to have_css("td#registry-vessel-name", text: registered_vessel.name)

      expect(page)
        .to have_css("td#vessel-name", text: "No change")
    end

    click_link("Owners")
    within("table#declaration_1") do
      expect(page).to have_css("th", count: 3)

      expect(page)
        .to have_css("td.registry-owner-name",
                     text: registered_vessel.owners.first.name)

      expect(page).to have_css("td.owner-name", text: "No change")
    end
  end
end
