require "rails_helper"

feature "User approves a closure", type: :feature, js: true do
  before do
    submission = create(:assigned_closure_submission)
    login_to_part_3(submission.claimant)
    visit submission_path(submission)
    click_link("Close Registration", href: "#approve-application")
  end

  scenario "in general" do
    within(".modal-content") do
      expect(page).not_to have_field("registration_starts_at")

      select("Failed to Renew", from: "Closure Reason")
      fill_in("Closure Date", with: "01/09/2011")
      click_button("Close Registration")
    end

    expect(page).to have_text("Registration Closure has been approved")

    pdf_window = window_opened_by do
      click_on("Print Closed Transcript")
    end

    within_window(pdf_window) do
      expect(page).to have_text("%PDF")
    end
  end
end
