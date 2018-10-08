require "rails_helper"

describe "User edits part_3 application" do
  scenario "in general" do
    visit_claimed_task(
      service: create(:demo_service, :update_registry_details))

    click_on(edit_application_link_text)
  end

  scenario "when the application cannot be edited" do
    visit_claimed_task(
      service: create(:demo_service, :registry_not_editable))

    expect(page).not_to have_link(edit_application_link_text)
  end
end

def edit_application_link_text
  "Edit Application"
end
