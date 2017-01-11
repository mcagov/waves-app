require "rails_helper"

feature "User creates a new submission", type: :feature do
  scenario "for a new registration" do
    @vessel = create(:registered_vessel)
    login_to_part_3
    click_on("Document Entry")
    within(".modal#start-new-application") { click_on("New Registration") }
    click_on("Save Application")

    expect(page)
      .to have_css("h1", text: "New Registration ID: ")
  end

  scenario "for another task, retrieve a vessel", js: true do
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

    expect(page)
      .to have_css("h1", text: "Re-Registration ID: ")
    expect(page)
      .to have_css("td.vessel-name", text: @vessel.name)
  end
end
