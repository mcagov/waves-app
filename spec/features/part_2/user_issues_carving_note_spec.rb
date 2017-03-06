require "rails_helper"

describe "User issues a Carving & Marking Note" do
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
