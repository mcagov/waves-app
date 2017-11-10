require "rails_helper"

describe "User issues a 7 Day Notice of termination", type: :feature, js: true do
  scenario "in general" do
    visit_registered_vessel

    click_on("Registrar Tools")
    click_on("Registration Closure: 7 Day Notice of Termination")

    expect(page).to have_text("Task Complete")

    vessel = Register::Vessel.last
    expect(vessel.registration_status).to eq(:frozen)
    expect(vessel.current_registration.termination_notice_at).to be_present

    pdf_window = window_opened_by do
      click_on("Print 7 Day Notice of Termination")
    end

    within_window(pdf_window) do
      expect(page).to have_text("%PDF")
    end

    creates_a_work_log_entry("Submission", :termination_notice)
  end

  scenario "when the 30 day section notice has not been generated"
end
