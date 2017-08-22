require "rails_helper"

describe "User edits charterers", js: :true do
  scenario "adding, editing and removing" do
    visit_name_approved_part_4_submission
    click_on("Charterers")
    click_on("Add Bareboat Charter")

    within(".modal.fade.in") do
      fill_in("Reference Number", with: "REF 1")
      fill_in("Start Date", with: "01/02/2001")
      fill_in("End Date", with: "01/02/2004")

      fill_in("Name of Party", with: "Alice")
      fill_in("Address of Party", with: "Wonderland")
      fill_in("Contact Details", with: "alice@example.com")

      click_on("Add Extra Party to the Charter")
      within all(".nested-fields")[1] do
        fill_in("Name of Party", with: "Charlie")
        within(".charterer_charter_parties_declaration_signed") do
          choose("Yes")
        end
      end

      click_on("Add Bareboat Charter")
    end

    within("#charterers_tab") do
      expect(page).to have_css(".reference_number", text: "REF 1")
      expect(page).to have_css(".start_date", text: "01/02/2001")
      expect(page).to have_css(".end_date", text: "01/02/2004")
      expect(page)
        .to have_css(".parties", text: "Name: ALICE (Pending Declaration")

      expect(page)
        .to have_css(".parties", text: "Name: CHARLIE (Declaration Signed")

      click_on("Edit")
    end

    within(".modal.fade.in") do
      fill_in("Reference Number", with: "REF 2")
      within all(".nested-fields")[1] { click_on("Remove") }
      fill_in("Name of Party", with: "Doris")

      click_on("Save Bareboat Charter")
    end

    within("#charterers_tab") do
      expect(page).to have_css(".reference_number", text: "REF 2")
      expect(page).to have_css(".parties", text: "Name: DORIS")
    end

    within("#charterers_tab") do
      click_on("Remove")
      expect(page).not_to have_css(".reference_number")
      expect(Submission.last.charterers).to be_empty
    end
  end
end
