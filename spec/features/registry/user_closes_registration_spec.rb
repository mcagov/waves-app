require "rails_helper"

describe "User closes a vessel's registration", type: :feature, js: true do
  scenario "By Owner Request" do
    visit_registered_vessel

    click_on("Registrar Tools")
    click_on("Registration Closure: Owner Request")

    expect(page).to have_css(".registration_status", text: "Closed")
    creates_a_work_log_entry("Submission", :registrar_closure)
    WorkLog.delete_all

    click_on("Registrar Tools")
    click_on("Restore Closed Registration")

    expect(page).to have_css(".registration_status", text: "Registered")
    creates_a_work_log_entry("Submission", :registrar_restores_closure)
  end

  scenario "Without Notice" do
    visit_registered_vessel

    click_on("Registrar Tools")
    click_on("Registration Closure: Close Without Notice")

    expect(page).to have_css(".registration_status", text: "Closed")
    creates_a_work_log_entry("Submission", :forced_closure)

    # print a closure letter and a closed transcript
  end
end
