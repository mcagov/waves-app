require "rails_helper"

feature "User creates a new submission for another task", type: :feature do
  before do
    login_to_part_3
    visit open_submissions_path
    @vessel = create(:registered_vessel)
    click_on("Document Entry")

    within(".modal#start-new-application") do
      click_on("Task for a Registered Vessel")
    end
  end

  scenario "assigning to a registered vessel", js: true do
    within(".modal#search-for-vessel") do
      search_for(@vessel.name)
      within("#vessels") { click_on("Use this") }
    end

    expect(page).to have_css(
      "#select2-submission_application_type-container",
      text: "Re-Registration")

    expect(find_field("Official Number").value).to eq(@vessel.reg_no)
    click_on("Save Application")

    expect(page).to have_text("saved to the unclaimed tasks queue")
    expect(Submission.last.application_type.to_sym).to eq(:re_registration)
  end

  scenario "when that vessel has an open application", js: true do
    create(:submission, registered_vessel: @vessel)

    within(".modal#search-for-vessel") do
      search_for(@vessel.name)
      within("#vessels") { click_on("Use this") }
    end

    click_on("Save Application")

    expect(page)
      .to have_css(
        ".submission_vessel_reg_no",
        text: "An open application already exists for this vessel")
  end
end
