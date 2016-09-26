require "rails_helper"

describe "User views a registered vessel", type: :feature, js: true do
  before do
    @submission = create_completed_application!
    login_to_part_3
    visit vessels_path
    click_on("Celebrator")
  end

  scenario "and links to the submission page (which can not be edited)" do
    expect(page).to have_css("h1", text: "Celebrator")

    click_on("People")
    expect(page).to have_css(".owner-name", text: "Horatio Nelson")

    click_on("Applications")
    click_on("New Registration")

    expect(page).not_to have_css("#actions")

    within("#vessel-name") do
      expect(page).to have_text("Celebrator")
      expect(page).not_to have_link("Celebrator")
    end
  end

  scenario "viewing history"
  scenario "viewing / adding correspondence"
  scenario "viewing /adding notes"
end
