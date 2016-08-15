require "rails_helper"

feature "User views dashboard", type: :feature, js: true do
  before do
    create_registration!
    login
  end

  scenario "payment flag" do
    within("#registrations") do
      expect(page).to have_css(".fa-times.i.red")
    end
  end
end
