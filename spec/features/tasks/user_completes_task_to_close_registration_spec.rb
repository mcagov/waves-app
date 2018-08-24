require "rails_helper"

describe "User completes task to close a vessel's registration", js: true do
  scenario "in general", js: true do
    service = create(:service, activities: [:close_registration])
    submission = create(:submission, :part_3_vessel)

    visit_claimed_task(service: service, submission: submission)

    click_on("Complete Task")
    within(".modal.fade.in") do
      select("Failed to renew", from: "Closure Reason")
      fill_in("Closure Date", with: "01/09/2011")
      fill_in("Supporting Info", with: "DONT WANT IT")
      click_on("Complete Task")
    end

    expect(page).to have_css(".registration_status", text: "Closed")
    wait_for_ajax
    registration = Registration.last
    expect(registration.description).to eq("Failed to renew")
    expect(registration.closed_at.to_date).to eq("01/09/2011".to_date)
    expect(registration.supporting_info).to eq("DONT WANT IT")
  end
end
