require "rails_helper"

describe "User issues a 30 day section notice", type: :feature, js: true do
  scenario "in general" do
    visit_registered_vessel

    click_on("Registrar Tools")
    click_on("Registration Closure: 30 Day Section Notice")

    select("56(1)(b)", from: "Regulation / Reason")
    fill_in("Evidence required", with: "Some text")
    click_on("Issue 30 Day Section Notice")

    expect(page).to have_text("Task Complete")

    vessel = Register::Vessel.last
    expect(vessel.registration_status).to eq(:frozen)
    expect(vessel.current_registration.section_notice_at).to be_present

    expect(vessel.section_notice.reason).to be_present

    pdf_window = window_opened_by do
      click_on("Print 30 Day Section Notice")
    end

    within_window(pdf_window) do
      expect(page).to have_text("%PDF")
    end

    creates_a_work_log_entry("Submission", :section_notice)
  end
end
