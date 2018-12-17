require "rails_helper"

describe "User prints a renewal reminder", type: :feature, js: true do
  scenario "in general" do
    visit_registered_vessel
    click_on("Registrar Tools")
    click_on(generate_renewal_reminder_link)

    expect(page).to have_css(".alert", text: "sent to the Print Queue")

    expect(PrintJob.all.map(&:template))
      .to match(%w(renewal_reminder_letter mortgagee_reminder_letter))
  end

  scenario "when the vessel is not registered" do
    visit_unregistered_vessel
    click_on("Registrar Tools")

    expect(page)
      .to have_css("a.disabled", text: generate_renewal_reminder_link)
  end
end

def generate_renewal_reminder_link
  "Generate Renewal Reminder Letter(s)"
end
