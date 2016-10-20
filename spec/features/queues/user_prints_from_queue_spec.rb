require "rails_helper"

describe "User prints from queue", type: :feature, js: true do
  before do
    create_printing_submission!
    login_to_part_3
    visit print_queue_certificates_path
  end

  scenario "processing the certificates" do
    expect(page).to have_css("h1", "Print Queue: Certificates of Registry")

    pdf_window = window_opened_by do
      click_on("Print Certificates of Registry")
    end

    within_window(pdf_window) do
      expect(page).to have_text("%PDF")
    end

    visit print_queue_certificates_path
    within(".certificate") { expect(page).to have_text("Printed: ") }

    pdf_window = window_opened_by do
      click_on("Print Cover Letters")
    end

    within_window(pdf_window) do
      expect(page).to have_text("%PDF")
    end
  end

  scenario "when viewing another part of the registry" do
    login_to_part_1
    visit print_queue_certificates_path

    expect(page).to have_content("There are no items in this queue")
  end
end
