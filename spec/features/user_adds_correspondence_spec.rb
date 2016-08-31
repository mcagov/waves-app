require "rails_helper"

feature "User adds correspondence", type: :feature, js: true do
  before do
    visit_completeable_submission
  end

  scenario "to a submission" do
    click_on("Correspondence")
    click_link("Add Correspondence")

    fill_in "Subject", with: "My Subject"
    select "Post", from: "Correspondence Format"
    fill_in "Date Received", with: "12/12/2015"
    fill_in "Content", with: "Hello Bob"
    click_on "Save Correspondence"

    click_on("Correspondence")
    click_on("My Subject")

    expect(page).to have_css("h4", text: "My Subject")
    expect(page).to have_css(".modal-body", text: "Hello Bob")
  end
end
