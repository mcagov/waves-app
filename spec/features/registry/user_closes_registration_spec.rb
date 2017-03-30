require "rails_helper"

describe "User closes a vessel's registration", type: :feature, js: true do
  scenario "in general" do
    visit_registered_vessel

    click_on("Registrar Tools")
    click_on("Registration Closure: Owner Request")

    expect(page).to have_css("#registration_status", text: "Closed")
    creates_a_work_log_entry("Submission", :registrar_closure)
    WorkLog.delete_all

    click_on("Registrar Tools")
    click_on("Restore Closed Registration")

    expect(page).to have_css("#registration_status", text: "Registered")
    creates_a_work_log_entry("Submission", :registrar_restores_closure)
  end
end
