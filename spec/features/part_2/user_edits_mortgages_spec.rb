require "rails_helper"

describe "User edits mortgages", js: :true do
  scenario "in general" do
    visit_name_approved_part_2_submission
    click_on("Mortgages")
    click_on("Add Mortgage")

    within(".modal.fade.in") do
      select("Intent", from: "Mortgage Type")
      fill_in("Reference Number", with: "REF 1")
      fill_in("Start Date", with: "01/02/2001")
      fill_in("End Date", with: "01/02/2004")
      fill_in("Mortgage Amount", with: "2000 pounds")
      fill_in("Mortgagor(s)", with: "Bob, Sally")

      click_on("Add Mortgage")
    end

    within("#mortgages") do
      expect(page).to have_css(".priority", text: "A")
      expect(page).to have_css(".mortgage_type", text: "Intent")
      expect(page).to have_css(".reference_number", text: "REF 1")
      expect(page).to have_css(".start_date", text: "01/02/2001")
      expect(page).to have_css(".end_date", text: "01/02/2004")
      expect(page).to have_css(".amount", text: "2000 pounds")
      expect(page).to have_css(".mortgagor", text: "Bob, Sally")

      click_on("Intent")
    end

    within(".modal.fade.in") do
      fill_in("Reference Number", with: "REF 2")
      click_on("Save Mortgage")
    end

    within("#mortgages") do
      expect(page).to have_css(".reference_number", text: "REF 2")
    end
  end

  scenario "adding a mortgagee"
  scenario "removing a mortgagee"
  scenario "removing a mortgage"
end
