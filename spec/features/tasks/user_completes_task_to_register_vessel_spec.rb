require "rails_helper"

describe "User completes task to register a vessel", js: true do
  scenario "in general", js: true do
    service =
      create(:service,
             activities:
             [
               :update_registry_details,
               :generate_new_5_year_registration,
             ])

    visit_claimed_task(service: service)

    click_on("Complete Task")
    within(".modal.fade.in") do
      fill_in("Date and Time", with: "13/12/2010")
      expect(find_field("Registration Expiry Date").value.to_date)
        .to eq(Time.zone.today.advance(years: 5))
      fill_in("Registration Expiry Date", with: "13/12/2030")
      click_on("Complete Task")
    end

    wait_for_ajax
    expect(page).to have_css(".registration_status", text: "Registered")

    registration = Registration.last
    expect(registration.registered_at.to_date).to eq("13/12/2010".to_date)
    expect(registration.registered_until.to_date).to eq("13/12/2030".to_date)
  end
end
