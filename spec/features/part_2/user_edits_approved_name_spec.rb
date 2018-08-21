require "rails_helper"

feature "User edits part 2 name and PLN", type: :feature, js: :true do
  scenario "for a new_registration" do
    visit_claimed_task(
      submission: create(:name_approval).submission,
      service: create(:demo_service, :generate_new_5_year_registration))

    click_on("Change Name or PLN")
    complete_name_approval_form

    within("#application-tools") do
      page.accept_confirm { click_on("Cancel Approved Name") }
    end

    expect(page).to have_text("The approved name has been cancelled")
    expect(@submission.name_approval).to be_blank
  end

  scenario "for an existing vessel" do
    visit_claimed_task(
      submission: create(:submission, :part_2_vessel),
      service: create(:demo_service, :update_registry_details))

    click_on("Change Name or PLN")
    expect(page).to have_field("Vessel Name", with: Submission.last.vessel)
    complete_name_approval_form
  end
end

def complete_name_approval_form
  fill_in("Vessel Name", with: "BOBS BOAT")
  select2("Full", from: "submission_name_approval_registration_type")
  select2("SOUTHAMPTON", from: "submission_name_approval_port_code")
  fill_in("Port Number", with: "99")

  click_on("Validate Name")
  click_on("Approve Name")

  expect(page).to have_current_path(submission_task_path(@submission, @task))
  expect(Submission.last.vessel.name).to eq("BOBS BOAT")
end
