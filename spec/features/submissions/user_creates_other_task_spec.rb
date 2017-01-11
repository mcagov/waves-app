require "rails_helper"

feature "User creates a new submission for another task", type: :feature do
  scenario "in general", js: true do
    @vessel = create(:registered_vessel)
    login_to_part_3
    click_on("Document Entry")

    within(".modal#start-new-application") do
      click_on("Task for a Registered Vessel")
    end

    within(".modal#search-for-vessel") do
      search_for(@vessel.name)
      within("#vessels") { click_on("Use this") }
    end

    expect(page).to have_css(
      "#select2-submission_task-container", text: "Re-Registration")
    expect(find_field("Official No.").value).to eq(@vessel.reg_no)
    click_on("Save Application")

    expect(page).to have_text("saved to the unclaimed tasks queue")
    expect(Submission.last.task.to_sym).to eq(:re_registration)
  end
end
