require "rails_helper"

feature "User adds a change of vessel", type: :feature do
  scenario "in general" do
    @vessel_reg_no = create(:registered_vessel).reg_no
    login_to_part_3
    click_on("Start a New Application")

    select("Change of Vessel details", from: "Application Type")
    fill_in("Official No.", with: @vessel_reg_no)
    click_on("Save Application")

    expect(page)
      .to have_css("h1", text: "Change of Vessel details ID: ")
  end
end
