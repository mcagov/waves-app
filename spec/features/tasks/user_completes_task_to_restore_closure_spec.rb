require "rails_helper"

describe "User completes task to close a vessel's registration", js: true do
  scenario "in general", js: true do
    service = create(:service, activities: [:restore_closure])
    submission = create(:submission, :closed_part_3_vessel)
    previous_registration = submission.registered_vessel.current_registration

    visit_claimed_task(service: service, submission: submission)

    expect(page).to have_css(".registration_status", text: "Closed")

    click_on("Complete Task")
    within(".modal.fade.in") do
      click_on("Complete Task")
    end

    expect(page).to have_css(".registration_status", text: "Registered")
    registration = submission.registered_vessel.reload.current_registration
    expect(registration.closed_at).to be_blank
    expect(registration.registered_at)
      .to eq(previous_registration.registered_at)
    expect(registration.registered_until)
      .to eq(previous_registration.registered_until)
  end
end
