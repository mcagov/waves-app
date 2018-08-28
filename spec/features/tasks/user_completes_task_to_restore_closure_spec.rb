require "rails_helper"

describe "User completes task to close a vessel's registration", js: true do
  scenario "in general", js: true do
    service = create(:service, activities: [:restore_closure])
    submission = create(:submission, :closed_part_3_vessel)

    visit_claimed_task(service: service, submission: submission)

    expect(page).to have_css(".registration_status", text: "Closed")

    click_on("Complete Task")
    within(".modal.fade.in") do
      fill_in("Date and Time", with: "13/12/2010")
      fill_in("Registration Expiry Date", with: "13/12/2030")
      click_on("Complete Task")
    end

    expect(page).to have_css(".registration_status", text: "Registered")
    registration = submission.reload.registration
    expect(registration.registered_at.to_date).to eq("13/12/2010".to_date)
    expect(registration.registered_until.to_date).to eq("13/12/2030".to_date)
  end
end
