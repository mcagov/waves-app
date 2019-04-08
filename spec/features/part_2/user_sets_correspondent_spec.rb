require "rails_helper"

describe "User sets the correspondent", js: true do
  let(:submission) { create(:submission, :part_2_vessel) }

  scenario "adding an owner and setting them as correspondent" do
    visit_claimed_task(
      submission: submission,
      service: create(:service, :update_registry_details))

    click_on("Owners & Shareholding")
    click_on("Add Individual Owner")

    fill_in("Email", with: "bob@example.com")
    fill_in("Name", with: "BOB BOLD")
    click_on("Save Individual Owner")

    within("#correspondent") do
      click_on("Add Correspondent")
      select("BOB BOLD", from: "Name")
      click_on("Save Correspondent")
    end

    expect(page).to have_css(".correspondent-name", text: "BOB BOLD")
  end

  scenario "checking that the delivery_address is set to the correspondent" do
    submission.delivery_address = {}
    submission.save

    visit_claimed_task(
      submission: submission,
      service: create(:service, :update_registry_details))

    click_on("Owners & Shareholding")
    click_on("Add Individual Owner")

    fill_in("Email", with: "bob@example.com")
    fill_in("Name", with: "BOB BOLD")
    fill_in("Address 1", with: "10 DOWNING ST")
    fill_in("Town or City", with: "LONDON")
    fill_in("Postcode", with: "ABC 123")
    click_on("Save Individual Owner")

    within("#correspondent") do
      click_on("Add Correspondent")
      select("BOB BOLD", from: "Name")
      click_on("Save Correspondent")
    end

    within(".applicant-delivery-address") do
      expect(page).to have_text(
        "BOB BOLD 10 DOWNING ST LONDON UNITED KINGDOM ABC 123")
    end
  end
end
