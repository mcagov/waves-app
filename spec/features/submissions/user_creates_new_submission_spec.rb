require "rails_helper"

feature "User creates a new submission", type: :feature do
  scenario "for a new registration" do
    @vessel = create(:registered_vessel)
    login_to_part_3
    click_on("Start a New Application")
    within(".modal") { click_on("New Registration") }
    click_on("Save Application")

    expect(page)
      .to have_css("h1", text: "New Registration ID: ")
  end
end
