require "rails_helper"

feature "User views new registration", type: :feature, js: true do
  before do
    visit root_path(as: create(:user))
  end

  scenario "on the dashboard" do
    expect(page).to have_content("My Tasks")
  end
end
