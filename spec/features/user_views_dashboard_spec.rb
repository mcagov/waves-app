require "rails_helper"

feature "User views dashboard", type: :feature, js: true do
  let!(:registration) { create_registration! }

  before do
    login
  end

  scenario "registrations" do
    within("#registrations") do
      expect(page).to have_content(registration.vessel_info[:name])
      expect(page).to have_content(registration.official_no)
      expect(page).to have_content(registration.applicant)
      expect(page).to have_content("New Registration")
      expect(page).to have_css(".fa-times.i.red")
      expect(page).to have_content(registration.target_date)
      expect(page).to have_content(registration.source)
    end
  end
end
