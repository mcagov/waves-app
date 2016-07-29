require "rails_helper"

feature "User views new registration", type: :feature, js: true do
  let!(:registration) { create(:registration) }

  before do
    visit root_path(as: create(:user))
  end

  scenario "on the dashboard" do
    byebug
    expect(page).to have_content(registration.vessel.name)
  end
end
