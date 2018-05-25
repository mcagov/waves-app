require "rails_helper"

feature "User claims a submission", type: :feature, js: true do
  before do
    create(:unassigned_submission)
    login_to_part_3

    click_link("Unclaimed Tasks")
  end

  scenario "claim and unclaim a submission" do
    within("tr.submission") { click_on("Claim") }
    expect(page).not_to have_css("tr.submission")

    click_link("My Tasks")
    within("tr.submission") { click_on("Unclaim") }
    expect(page).not_to have_css("tr.submission")
  end

  scenario "claim a submission from the submission page" do
    within("tr.submission") { click_on("Boaty Mc") }

    click_on("Claim")
    expect(page)
      .to have_css(".alert-info", text: "successfully claimed this application")
  end
end
