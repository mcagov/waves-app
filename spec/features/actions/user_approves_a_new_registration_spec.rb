require "rails_helper"

feature "User approves a new registration", type: :feature, js: true do
  before do
    visit_assigned_submission
    click_link("Complete Registration")
  end

  scenario "setting the registration start date" do
    within(".modal-content") do
      expect(find_field("registration_starts_at").value.to_date)
        .to eq(Date.today)

      fill_in "registration_starts_at", with: "12/12/2020 11:59 AM"
      click_button("Register Vessel")
    end
    expect(page).to have_text("The vessel owner has been notified via email")
    expect(page).to have_text("registered on Part III of the UK Ship Register")

    expect(Registration.last.registered_at)
      .to eq("12/12/2020 11:59 AM".to_datetime)
  end

  scenario "printing the certificate" do
    within(".modal-content") do
      click_button("Register Vessel")
    end
    expect(page).to have_text("The vessel owner has been notified via email")

    pdf_window = window_opened_by do
      click_on("Print Certificate of Registry")
    end

    within_window(pdf_window) do
      expect(page).to have_text("%PDF")
    end

    expect(Submission.last.print_jobs["registration_certificate"]).to be_truthy
  end

  scenario "printing the cover letter" do
    within(".modal-content") do
      click_button("Register Vessel")
    end
    expect(page).to have_text("The vessel owner has been notified via email")

    pdf_window = window_opened_by do
      click_on("Print Cover Letter")
    end

    within_window(pdf_window) do
      expect(page).to have_text("%PDF")
    end

    expect(Submission.last.print_jobs["cover_letter"]).to be_truthy
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
