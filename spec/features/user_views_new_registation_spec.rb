require "rails_helper"

feature "User views new registration", type: :feature, js: true do
  let!(:registration) { create_registration! }

  before do
    visit root_path(as: create(:user))
  end

  scenario "details page" do
    click_on registration.vessel_info["name"]

    within(".registration") do
      expect(page).to have_content(registration.vessel_info["name"])
      expect(page).to have_content(registration.vessel_info["hin"])
      expect(page).to have_content(registration.vessel_info["make_and_model"])
      expect(page).to have_content(registration.vessel_info["length_in_centimeters"])
      expect(page).to have_content(registration.vessel_info["number_of_hulls"])
      expect(page).to have_content(registration.vessel_info["vessel_type.name"])
      expect(page).to have_content(registration.vessel_info["mmsi_number"])
      expect(page).to have_content(registration.vessel_info["radio_call_sign"])
    end
  end
end
