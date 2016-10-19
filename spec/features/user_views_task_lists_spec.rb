require "rails_helper"

feature "User views task lists", type: :feature, js: true do
  before do
    create_unassigned_submission!
    create(:finance_payment)
    login_to_part_3
  end

  scenario "viewing task lists" do
    click_link("My Tasks")
    expect(page).to have_css("h1", text: "My Tasks")

    click_link("Team Tasks")
    expect(page).to have_css("h1", text: "Team Tasks")

    click_link("Unclaimed Tasks")
    expect(page).to have_css("h1", text: "Unclaimed Tasks")

    click_link("Referred Applications")
    expect(page).to have_css("h1", text: "Referred Applications")

    click_link("Incomplete Applications")
    expect(page).to have_css("h1", text: "Incomplete Applications")

    click_link("Rejected Applications")
    expect(page).to have_css("h1", text: "Rejected Applications")

    click_link("Referred Applications")
    expect(page).to have_css("h1", text: "Referred Applications")
  end
end
