require "rails_helper"

feature "User registers a vessel", type: :feature, js: true do
  before do
    visit_claimed_submission
    click_link('Register Vessel')
  end

  scenario "in its simplest form" do
    within('.modal-content') do
      click_button('Register Vessel')
    end
    expect(page).to have_text("The vessel is now registered")
  end

  scenario "with email notification" do
    within('.modal-content') do
      check('Send a copy of the Certificate of Registry to owner')
      click_button('Register Vessel')
    end
    expect(page).to have_text("The vessel owner has been notified via email")
  end
end
