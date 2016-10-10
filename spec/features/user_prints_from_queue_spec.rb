require "rails_helper"

describe "User prints from queue", type: :feature, js: true do
  before do
    create_printing_submission!
    login_to_part_3
    visit print_queue_certificates_path
  end

  scenario "processing the certificates" do
    expect(page).to have_css("h1", "Print Queue: Certificates of Registry")

    click_on("Print Certificates of Registry")
    expect(page).to have_text("%PDF")

    visit print_queue_certificates_path
    within(".certificate") { expect(page).to have_text("Printed: ") }

    click_on("Print Cover Letters")
    expect(page).to have_text("%PDF")

    visit print_queue_certificates_path
    expect(page).to have_text("No items")
  end
end
