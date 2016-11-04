require "rails_helper"

feature "User processes next application", type: :feature, js: true do
  before do
    submission = create(:assigned_submission)
    login_to_part_3(submission.claimant)
  end

  scenario "clicking Process Next Application" do
    click_link("Process Next Application")

    click_link("Register Vessel")
    click_button("Register Vessel")
    expect(page).to have_text("Task Complete")

    click_link("My Tasks")
    click_link("Process Next Application")
    click_on("Get More Work")
    expect(page).to have_css("h1", text: "Unclaimed Tasks")
  end
end
