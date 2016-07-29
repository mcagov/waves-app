require "rails_helper"

feature "User views new registration", type: :feature, js: true do
  let!(:registration) { create(:registration) }

  before do
    visit root_path(as: create(:user))
  end

  scenario "details page" do
    click_on registration.vessel.name

    within(".registration") do
      expect(page).to have_content(registration.vessel.name)
      expect(page).to have_content(registration.vessel.hin)
      expect(page).to have_content(registration.vessel.make_and_model)
      expect(page).to have_content(registration.vessel.length_in_centimeters)
      expect(page).to have_content(registration.vessel.number_of_hulls)
      expect(page).to have_content(registration.vessel.vessel_type.name)
      expect(page).to have_content(registration.vessel.mmsi_number)
      expect(page).to have_content(registration.vessel.radio_call_sign)
    end
  end
end
