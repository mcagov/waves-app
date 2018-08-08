require "rails_helper"

describe "Registry not editable" do
  scenario "in general" do
    visit_claimed_task(
      service: create(:demo_service, :registry_not_editable))

    expect_task_to_be_active
    expect_application_info_panel
    expect_application_tasks_panel
    expect_task_actions

    expect(page).to have_text(registry_not_editable)
  end
end

def registry_not_editable
  "This task does not permit editing of registry details."
end
