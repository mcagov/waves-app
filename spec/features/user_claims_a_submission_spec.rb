require "rails_helper"

feature "User claims a submission", type: :feature, js: true do
  before do
    create_unassigned_submission!
    login_to_part_3
  end

  scenario "claim and unclaim a submission" do
    click_link("Unclaimed Tasks")

    within("tr.submission") { click_on("Claim") }
    expect(page).not_to have_css("tr.submission")

    click_link("My Tasks")
    within("tr.submission") { click_on("Unclaim") }
    expect(page).not_to have_css("tr.submission")
  end
end
