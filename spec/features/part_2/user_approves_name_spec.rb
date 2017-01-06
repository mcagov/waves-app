require "rails_helper"

feature "User approves a part 2 name", type: :feature do
  scenario "in general" do
    login_to_part_2

    click_on("Start a New Application")
    within(".modal#start-new-application") { click_on("New Registration") }
    click_on("Save Application")

    fill_in("Approved Vessel Name", with: "BOBS BOAT")
    select("Simple", from: "Registration Type")
    select("SOUTHAMPTON", from: "Port of Choice")
    fill_in("Port No", with: "12345")
    fill_in("Net Tonnage", with: "10000")
  end
end
