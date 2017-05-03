require "rails_helper"

describe "User views staff performance report", js: true do
  before do
    login_to_part_3
    find("a.reports_menu").click
    click_on("Staff Performance")
  end

  scenario "in general" do
    expect(page).to have_css("h1", text: "Reports: Staff Performance")
    expect(page).to have_css("th", text: "Task Type")
    expect(page).to have_css("th", text: "Total Transactions")
    expect(page).to have_css("th", text: "Top Performer")
  end
end
