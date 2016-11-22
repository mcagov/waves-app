require "rails_helper"

feature "User adds a new submission", type: :feature do
  before { login_to_part_3 }

  scenario "for a new registration" do
    click_on("Start a New Application")

    select("New Registration", from: "Application Type")
    fill_in("Date Document Received", with: "1/1/2016")

    fill_in("Applicant Name", with: "Bob")
    fill_in("Applicant's Email Address", with: "bob@example.com")
    check("Send an Application Receipt email")

    click_on("Save Application")

    expect(page).to have_css("h1", text: "New Registration ID: ")
  end
end
