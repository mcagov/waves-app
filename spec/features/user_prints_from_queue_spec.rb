require "rails_helper"

describe "User prints from queue", type: :feature, js: true do
  before do
    create_printing_submission!
    visit print_queue_certificates_path
  end

  scenario "processing the certificates" do
    expect(page).to have_css("h1", "Print Queue: Certificates of Registry")

    # expect(page).to have_css(".certificate", text: "In Queue")
    # expect(page).to have_css(".cover-letter", text: "In Queue")

    # click_button("Process Print Queue")
    # expect(page).to have_text("%PDF")

    # expect(page).to have_css(".certificate", text: "Printed")
    # expect(page).to have_css(".cover-letter", text: "In Queue")

    # click_on("Process Cover Letters")
    # expect(page).to have_text("%PDF")

    # expect(page).to have_css(".disabled", "Process Print Queue")
  end
end
