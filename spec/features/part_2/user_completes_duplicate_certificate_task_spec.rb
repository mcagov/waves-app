require "rails_helper"

describe "User completes duplicate certificate task", js: true do
  before do
    visit_claimed_task(
      service: create(:service, :duplicate_registration_certificate),
      submission: create(:submission, :part_2_vessel))
  end

  scenario "in general" do
    click_on("Complete Task")
    within(".modal.fade.in") { click_on("Complete Task") }

    within("#application-tools") do
      expect(page).to have_link("Print Duplicate Certificate of Registry")
    end

    visit "/print_queue/duplicate_registration_certificate"

    pdf_window = window_opened_by do
      click_on("Print Duplicate Certificates of Registry")
    end

    within_window(pdf_window) do
      expect(page).to have_text("%PDF")
    end
  end
end
