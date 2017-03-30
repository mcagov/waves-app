require "rails_helper"

describe "User issues a notice of termination", type: :feature, js: true do
  scenario "in general" do
    visit_registered_vessel

    click_on("Registrar Tools")
    click_on("Registration Closure: Notice of Termination")

    expect(page).to have_text("Task Complete")
    creates_a_work_log_entry("Submission", :termination_notice)
  end
end
