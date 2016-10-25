require "rails_helper"

describe "User views a registered vessel", type: :feature, js: true do
  before do
    @submission = create_completed_submission!
    @vessel = Register::Vessel.last
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

  scenario "adding a note with two attachments" do
    click_on("Notes")
    click_on("Add Note")

    fill_in("Content", with: "Some stuff")
    page.attach_file(
      "note_assets_attributes_0_file", "spec/support/files/mca_test.pdf")
    page.attach_file(
      "note_assets_attributes_1_file", "spec/support/files/mca_test.jpg")
    click_on("Save Note")

    click_on("Notes")
    expect(page).to have_link("mca_test.pdf", href: /mca_test.pdf/)
    expect(page).to have_link("mca_test.jpg", href: /mca_test.jpg/)

    click_on("Some stuff")
    expect(page).to have_css(".modal-body", text: "Some stuff")
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
      expect(page).to have_link(@vessel.reg_no, href: vessel_path(@vessel))
    end
  end

  scenario "viewing the registration status" do
    expect(page).to have_css(".label-success", text: "Registered")

    registration = Registration.last
    registration.update_attributes(registered_until: 1.day.ago)

    visit vessel_path(registration.vessel)
    expect(page).to have_css(".label-danger", text: "Registration Expired")
  end
end
