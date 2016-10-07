require "rails_helper"

feature "User approves a new registration", type: :feature, js: true do
  before do
    visit_assigned_submission
    click_link("Register Vessel")
  end

  scenario "printing the certificate" do
    within(".modal-content") do
      click_button("Register Vessel")
    end
    expect(page).to have_text("The vessel owner has been notified via email")

    click_on("Print Certificate of Registry")
    expect(page).to have_text("%PDF")
  end

  scenario "printing the cover letter" do
    within(".modal-content") do
      click_button("Register Vessel")
    end
    expect(page).to have_text("The vessel owner has been notified via email")

    click_on("Print Cover Letter")
    expect(page).to have_text("%PDF")
  end

  scenario "attaching certificate to the email" do
    within(".modal-content") do
      check "Send a copy of the Certificate"
      click_button("Register Vessel")
    end
    expect(page).to have_text("The vessel owner has been notified via email")
    expect(Notification::ApplicationApproval.last.attachments)
      .to match(/registration_certificate/)
  end
end
