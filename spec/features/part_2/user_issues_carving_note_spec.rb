require "rails_helper"

describe "User issues a Carving & Marking Note", js: true do
  scenario "by email" do
    visit_carving_and_marking_ready_submission
    click_on("Certificates & Documents")

    within("#carving_and_marking .status") do
      click_on("Issue Carving & Marking Note")
    end

    within(".modal-content") do
      select("Register Tonnage", from: "Tonnage Type")
      select("Send via Email", from: "Delivery Method")
      select("Part 1 pleasure vessels under 24m", from: "Template")
      click_on("Issue Carving & Marking note")
    end

    within("#carving_and_marking") do
      expect(page).to have_css(".delivery_method", text: "Email")
    end

    expect(Notification::CarvingAndMarkingNote.count).to eq(1)
    creates_a_work_log_entry("Submission", :issued_carving_and_marking_note)
  end

  scenario "as a printed page"

  scenario "when the pre-requisites have not been met" do
    visit_name_approved_part_2_submission
    click_on("Certificates & Documents")

    within("#carving_and_marking .status") do
      expect(page).to have_css(".red", text: "Official Number required")
      expect(page).to have_css(".red", text: "Net or Register Tonnage required")
    end
  end
end
