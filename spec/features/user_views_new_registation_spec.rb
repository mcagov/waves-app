require "rails_helper"

feature "User views new registration", type: :feature, js: true do
  let!(:registration) { create_paid_registration! }

  before do
    login
    click_on registration.vessel_info[:name]
  end

  scenario "heading" do
    within("h1") do
      expect(page).to have_content("New Registration")
    end
  end

  scenario "vessel info" do
    within(".registration") do
      expect(page).to have_content(registration.vessel_info[:name])
      expect(page).to have_content(registration.vessel_info[:hin])
      expect(page).to have_content(registration.vessel_info[:make_and_model])
      expect(page).to have_content(registration.vessel_info[:length_in_meters])
      expect(page).to have_content(registration.vessel_info[:number_of_hulls])
      expect(page).to have_content(registration.vessel_info[:vessel_type])
      expect(page).to have_content(registration.vessel_info[:mmsi_number])
    end
  end

  scenario "owner info", javascript: true do
    click_link("Owners")

    within("#owner_1") do
      expect(page).to have_css('th', text: "Owner #1")
      expect(page).to have_css('.owner-name', text: "Horatio Nelson")
      expect(page).to have_css('.declaration', text: "Completed online")
      expect(page).to have_css('.payment', text: "Registered Country of Credit Card: GB")
    end

    within("#owner_2") do
      expect(page).to have_css('th', text: "Owner #2")
      expect(page).to have_css('.owner-name', text: "Edward McCallister")
    end
  end

  scenario "declaration status"
end
