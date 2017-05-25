require "rails_helper"

describe "User edits mortgages", js: :true do
  scenario "adding, editing and removing" do
    visit_name_approved_part_2_submission
    click_on("Mortgages")
    click_on("Add Mortgage")

    within(".modal.fade.in") do
      select("A", from: "Priority Code")
      select("Intent", from: "Mortgage Type")
      fill_in("Reference Number", with: "REF 1")
      fill_in("Date Executed", with: "01/02/2001")
      fill_in("Mortgage Amount", with: "2000 pounds")
      fill_in("Name of Mortgagor", with: "Mary")

      click_on("Add Extra Mortgagor")
      within all("#mortgagors .nested-fields")[1] do
        fill_in("Name of Mortgagor", with: "Bob")
      end

      fill_in("Name of Mortgagee", with: "Alice")
      fill_in("Address of Mortgagee", with: "Wonderland")
      fill_in("Contact Details", with: "alice@example.com")

      click_on("Add Extra Mortgagee")
      within all("#mortgagees .nested-fields")[1] do
        fill_in("Name of Mortgagee", with: "Charlie")
      end

      click_on("Add Mortgage")
    end

    within("#mortgages_tab") do
      expect(page).to have_css(".priority", text: "A")
      expect(page).to have_css(".mortgage_type", text: "Intent")
      expect(page).to have_css(".reference_number", text: "REF 1")
      expect(page).to have_css(".executed_at", text: "Thu Feb 01, 2001")
      expect(page).to have_css(".amount", text: "2000 pounds")
      expect(page).to have_css(".mortgagors", text: "MARY, BOB")

      expect(page).to have_css(".mortgagees", text: "ALICE, CHARLIE")

      click_on("Intent")
    end

    within(".modal.fade.in") do
      fill_in("Reference Number", with: "REF 2")
      within all("#mortgagors .nested-fields")[1] { click_on("Remove") }
      within all("#mortgagees .nested-fields")[1] { click_on("Remove") }
      fill_in("Name of Mortgagee", with: "Doris")

      click_on("Save Mortgage")
    end

    within("#mortgages_tab") do
      expect(page).to have_css(".reference_number", text: "REF 2")
      expect(page).to have_css(".mortgagors", text: "MARY")
      expect(page).to have_css(".mortgagees", text: "DORIS")
    end

    within("#mortgages_tab") do
      click_on("Remove")
      expect(page).not_to have_css(".reference_number")
      expect(Submission.last.mortgages).to be_empty
    end
  end
end
