require "rails_helper"

describe "User edits managers", js: :true do
  scenario "in general" do
    visit_name_approved_part_1_submission
    expect_managers(true)

    click_on("Manager")
    click_on("Add Manager")

    within(".modal.fade.in") do
      expect_postcode_lookup
      fill_in("Name", with: "BOB BOLD")
      fill_in("IMO Number", with: "1234567")
      click_on("Save Manager")
    end

    expect(page).to have_css(".manager-imo_number", text: "1234567")

    click_on("BOB BOLD")
    fill_in("IMO Number", with: "7654321")
    click_on("Save Manager")

    expect(page).to have_css(".manager-imo_number", text: "7654321")

    within("#managers") do
      click_on("Remove")
      expect(page).not_to have_css(".manager-name")
      expect(Submission.last.managers).to be_empty
    end
  end
end
