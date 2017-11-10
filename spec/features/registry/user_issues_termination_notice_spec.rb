require "rails_helper"

describe "User issues a 7 Day Notice", type: :feature, js: true do
  scenario "when the vessel is frozen and the 30 day notice has been issued" do
    login_to_part_3
    vessel = create(:registered_vessel)
    vessel.current_registration.update_attribute(:section_notice_at, Time.now)
    vessel.update_attribute(:frozen_at, Time.now)
    visit vessel_path(vessel)

    click_on("Registrar Tools")
    click_on(notice_of_termination_link)

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

  scenario "when the 30 day section notice has not been generated" do
    visit_registered_vessel
    click_on("Registrar Tools")
    expect(page).not_to have_link(notice_of_termination_link)
  end
end

def notice_of_termination_link
  "Registration Closure: 7 Day Notice of Termination"
end
