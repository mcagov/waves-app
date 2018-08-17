require "rails_helper"

describe "User completes a task", js: true do
  scenario "in general" do
    service =
      create(:demo_service,
             activities: [:perform_a_given_task],
             print_templates: [:cover_letter])

    visit_claimed_task(service: service)

    within("#actions") { click_on("Complete Task") }

    within("#task-activities") do
      expect(page).to have_text("Perform a given task")
    end

    within("#task-print-templates") do
      expect(page).to have_text("Cover letter")
    end

    within(".modal.fade.in") { click_on "Complete Task" }

    expect(page).to have_text("The task has been completed")
    expect(@task.reload).to be_completed

    creates_a_work_log_entry("Submission::Task", :completed)
  end

  scenario "when the task has validation errors" do
    visit_claimed_task(
      submission: create(:submission, part: :part_1, correspondent_id: nil),
      service: create(:demo_service, :validates_on_approval))

    within("#actions") { click_on("Complete Task") }

    within("#task-validation-errors") do
      expect(page).to have_text("correspondent is required")
    end
  end

  scenario "to register a vessel", js: true do
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

    expect(page).to have_css(".official-no", text: "SSR2000")
    registration = Registration.last
    expect(registration.registered_at.to_date).to eq("13/12/2010".to_date)
    expect(registration.registered_until.to_date).to eq("13/12/2030".to_date)
  end

  scenario "to close a vessel's registration", js: true do
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
    registration = Registration.last
    expect(registration.description).to eq("Failed to renew")
    expect(registration.closed_at.to_date).to eq("01/09/2011".to_date)
    expect(registration.supporting_info).to eq("DONT WANT IT")
  end
end
