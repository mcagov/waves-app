require "rails_helper"

feature "User views submission for similar vessel", type: :feature, js: true do
  scenario "viewing a vessel with similar name and different mmsi_number" do
    create(:register_vessel, mmsi_number: 233878594)
    create(:register_vessel, name: "Celebrator Doppelbock")
    visit_assigned_submission

    # submitted vessel information
    within("td#vessel-name") do
      expect(page).to have_css(".i.fa.fa-star-o")
    end

    # similar vesels pane
    within("#similar-vessels") do
      expect(page).to have_text("Similar Vessels")

      within(".vessel-name", text: "Celebrator Doppelbock") do
        expect(page).to have_css(".i.fa.fa-star-o")
        click_link("Celebrator Doppelbock")
      end
    end

    expect(page).to have_css("h1", "Celebrator Doppelbock")
  end

  scenario "no similar vessels" do
    visit_assigned_submission
    expect(page).not_to have_css("#similar-vessels")
  end
end
