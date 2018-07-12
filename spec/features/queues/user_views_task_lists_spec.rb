require "rails_helper"

feature "User views task lists", type: :feature, js: true do
  before { login_to_part_3 }

  scenario "viewing task lists" do
    click_link("My Tasks")
    expect(page).to have_css("h1", text: "My Tasks")

    click_link("Team Tasks")
    expect(page).to have_css("h1", text: "Team Tasks")

    click_link("Unclaimed Tasks")
    expect(page).to have_css("h1", text: "Unclaimed Tasks")

    click_link("Referred Tasks")
    expect(page).to have_css("h1", text: "Referred Tasks")

    click_link("Cancelled Tasks")
    expect(page).to have_css("h1", text: "Cancelled Tasks")
  end

  scenario "viewing finance_payments" do
    visit "/finance_payments/unattached_refunds"
    click_link("Fees Received")
    expect(page).to have_css("h1", text: "Fees Received")

    click_link("Refunds Due")
    expect(page).to have_css("h1", text: "Refunds Due")
  end
end
