require "rails_helper"

describe "User prints from queue", type: :feature, js: true do
  before do
    create_printing_submission!
    login_to_part_3
    visit print_queue_certificates_path
  end

  scenario "processing the certificates" do
    expect(page).to have_css("h1", "Print Queue: Certificates of Registry")

    within(".certificate") { expect(page).to have_css(".fa-times.red") }
    within(".cover-letter") { expect(page).to have_css(".fa-times.red") }

    click_button("Process Print Queue")
    expect(page).to have_text("%PDF")

    within(".certificate") { expect(page).to have_css(".fa-cross.green") }
    within(".cover-letter") { expect(page).to have_css(".fa-times.red") }

    click_on("Process Cover Letters")
    expect(page).to have_text("%PDF")

    expect(page).to have_css(".disabled", "Process Print Queue")
  end
end
