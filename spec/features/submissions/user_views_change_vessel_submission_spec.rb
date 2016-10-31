require "rails_helper"

feature "User views change of details submission", type: :feature, js: true do
  let!(:submission) { create_unassigned_submission! }

  before do
    submission.update_attribute(:registry_info, submission.changeset)
    submission.update_attribute(:task, :change_vessel)
    login_to_part_3
    click_link "Unclaimed Tasks"
    click_on submission.vessel.name
  end

  scenario "heading" do
    within("h1") do
      expect(page).to have_content("Change of Vessel Details ID: ")
    end
  end

  scenario "vessel info renders three column table", javascript: true do
    click_link("Vessel Information")

    within("table.submission-vessel") do
      expect(page).to have_css("th", count: 3)

      expect(page)
        .to have_css("td#registry-vessel-name", text: "CELEBRATOR DOPPELBOCK")

      expect(page)
        .to have_css("td#vessel-name", text: "No change")
    end
  end
end
