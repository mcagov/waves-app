require "rails_helper"

feature "User creates a new submission for another task", type: :feature do
  before do
    @vessel = create(:registered_vessel)
    login_to_part_3
    click_on("Document Entry")
  end

  scenario "assigning to a registered vessel", js: true do
    within(".modal#start-new-application") do
      click_on("Task for a Registered Vessel")
    end

    within(".modal#search-for-vessel") do
      search_for(@vessel.name)
      within("#vessels") { click_on("Use this") }
    end

    expect(page).to have_css(
      "#select2-submission_document_entry_task-container",
      text: "Re-Registration")

    expect(find_field("Official Number").value).to eq(@vessel.reg_no)
    click_on("Save Application")

    expect(page).to have_text("saved to the unclaimed tasks queue")
    expect(Submission.last.document_entry_task.to_sym).to eq(:re_registration)
  end
end
