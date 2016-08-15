require "rails_helper"

feature "User views new registration", type: :feature, js: true do
  let!(:registration) { create_registration! }

  before do
    login
    click_on registration.vessel_info[:name]
  end

  scenario "vessel info" do
    within(".registration") do
      expect(page).to have_content(registration.vessel_info[:name])
      expect(page).to have_content(registration.vessel_info[:hin])
      expect(page).to have_content(registration.vessel_info[:make_and_model])
      expect(page).to have_content(registration.vessel_info[:length_in_cenimeters])
      expect(page).to have_content(registration.vessel_info[:number_of_hulls])
      expect(page).to have_content(registration.vessel_info[:vessel_type])
      expect(page).to have_content(registration.vessel_info[:mmsi_number])
    end
  end

  scenario "owner_info"
end
