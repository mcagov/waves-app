require "rails_helper"

feature "User registers a vessel", type: :feature, js: true do
  before do
    create_paid_submission!
    login
  end

  scenario "in its simplest form" do
    within('tr.submission') { click_on("Claim") }

    click_link('Register Vessel')

    within('.modal-content') { click_button('Register Vessel') }

    expect(page).to have_text("vessel is now registered")
  end
end
