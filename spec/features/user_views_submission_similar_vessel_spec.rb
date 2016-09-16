require "rails_helper"

feature "User views submission for similar vessel", type: :feature, js: true do
  scenario "viewing a similar vessel" do
    create(:vessel, mmsi_number: 233878594)
    create(:vessel, name: "Celebrator Doppelbock")
    visit_assigned_submission

    within("#similar-vessels") do
      expect(page).to have_text("Similar Vessels")
      click_link("Celebrator Doppelbock")
    end

    expect(page).to have_css("h1", "Celebrator Doppelbock")
  end

  scenario "no similar vessels" do
    visit_assigned_submission
    expect(page).not_to have_css("#similar-vessels")
  end
end
