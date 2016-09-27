require "rails_helper"

describe "User views a registered vessel", type: :feature, js: true do
  before do
    @submission = create_completed_submission!
    login_to_part_3
    visit vessels_path
    click_on("Celebrator")
  end

  scenario "viewing vessel details" do
    click_on("People")
    expect(page).to have_css(".owner-name", text: "Horatio Nelson")

    click_on("History")
    expect(page).to have_css(".history-item", "New Registration")

    click_on("Correspondence")
    expect(page).to have_link("Add Correspondence")
  end

  scenario "adding notes" do
    click_on("Notes")
    click_on("Add Note")
    fill_in("Content", with: "Some stuff")
    click_on("Save Note")

    click_on("Notes")
    within("#notes") do
      click_on("Some stuff")
      expect(page).to have_css(".modal-body", text: "Some stuff")
    end
  end

  scenario "linking to the submission page (which can not be edited)" do
    expect(page).to have_css("h1", text: "Celebrator")

    click_on("Applications")
    click_on("New Registration")

    within("#vessel-name") do
      expect(page).to have_text("Celebrator")
      expect(page).not_to have_link("Celebrator")
    end

    expect(page).not_to have_css("#actions")

    within(".breadcrumb") do
      expect(page).to have_link("Registered Vessels", href: vessels_path)
      click_on(@submission.registered_vessel.reg_no)
    end

    expect(page)
      .to have_current_path("/vessels/#{@submission.registered_vessel.id}")
  end
end