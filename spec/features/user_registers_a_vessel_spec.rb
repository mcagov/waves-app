require "rails_helper"

feature "User registers a vessel", type: :feature, js: true do
  before do
    create_paid_submission!
    login
  end

  scenario "in its simplest form" do
    within('tr.submission') { click_on("Claim") }
    within('tr.submission') { click_on("Celebrator") }
    click_link('Register Vessel')
    within('.modal-content') { click_button('Register Vessel') }

    expect(page).to have_text("vessel is now registered")
    visit tasks_my_tasks_path
    expect(page).not_to have_css('tr.submission')
  end
end
