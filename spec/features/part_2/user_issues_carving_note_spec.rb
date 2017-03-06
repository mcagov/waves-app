require "rails_helper"

describe "User issues a Carving & Marking Note", js: true do
  scenario "in general" do
    visit_carving_and_marking_ready_submission
    click_on("Certificates & Documents")

    within("#carving .status") do
      expect(page).to have_text("Not Issued")
      click_on("Issue Carving & Marking Note")
    end
  end

  scenario "when the pre-requisites have not been met" do
    visit_name_approved_part_2_submission
    click_on("Certificates & Documents")

    within("#carving .status") do
      expect(page).to have_text("Not Issued")
      expect(page).to have_css(".red", text: "Official Number required")
      expect(page).to have_css(".red", text: "Net or Register Tonnage required")
    end
  end
end
