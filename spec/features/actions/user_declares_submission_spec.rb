require "rails_helper"

feature "User declares a submission", js: true do
  before do
    visit_claimed_task
  end

  scenario "uploading a completed form" do
    click_on("Owners")
    click_on("Complete Declaration")
    click_on("Owners")
    expect(page).to have_text("Completed by")
  end
end
