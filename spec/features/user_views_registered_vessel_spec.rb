require "rails_helper"

describe "User views a registered vessel", type: :feature, js: true do
  before do
    @submission = create_completed_submission!
    login_to_part_3
    visit vessels_path
    click_on("CELEBRATOR")
  end

  scenario "viewing vessel details" do
    click_on("Owners")
    expect(page).to have_css(".owner-name", text: "HORATIO NELSON")

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
    expect(page).to have_css("h1", text: "CELEBRATOR")

    click_on("Application History")
    click_on("New Registration")

    within("#vessel-name") do
      expect(page).to have_text("CELEBRATOR")
      expect(page).not_to have_link("CELEBRATOR")
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
