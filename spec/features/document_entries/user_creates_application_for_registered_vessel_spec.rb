require "rails_helper"

feature "User creates application for a registered vessel", js: true do
  scenario "in general" do
    registered_vessel = create(:registered_vessel, name: "BARNEY BOAT")
    login_to_part_3
    visit open_submissions_path
    click_on("Document Entry")

    within(".modal.fade.in") do
      click_on("Application for a Registered Vessel")
      find_field("search").set("BARNEY BOAT")
      click_on("Go!")
      click_on("Use this vessel")
    end

    click_on("Save Application")

    expect(page).to have_text("The application has been created")
    expect(page).to have_css("h1", text: "BARNEY BOAT")

    # check that the changeset was built from the registry
    submission = Submission.last
    expect(submission.owners.map(&:name))
      .to match(registered_vessel.owners.map(&:name))
  end
end
