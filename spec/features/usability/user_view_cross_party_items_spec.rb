require "rails_helper"

feature "User views cross party items", type: :feature, js: true do
  before do
    login_to_part_2
  end

  scenario "viewing a vessel in part 3" do
    visit vessel_path(create(:registered_vessel))

    expect(page).to have_css(".active-register", text: "Active: Part III")
  end

  scenario "viewing a submission in part 3" do
    visit submission_path(create(:submission))

    expect(page).to have_css(".active-register", text: "Active: Part III")
  end
end
