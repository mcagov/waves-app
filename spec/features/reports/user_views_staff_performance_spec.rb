require "rails_helper"

describe "User views staff performance report", js: true do
  before do
    @submission = create(:completed_submission)
    login_to_part_3
    find("a.reports_menu").click
    click_on("Staff Performance")
  end

  scenario "in general" do
    expect(page).to have_css("h1", text: "Reports: Staff Performance")
    expect(page).to have_css("th", text: "Task Type")
    expect(page).to have_css("th", text: "Total Transactions")
    expect(page).to have_css("th", text: "Top Performer")

    expect(page).to have_css("td", text: "New Registration")
  end

  scenario "filtering by part" do
    part_three_result = "New Registration 1 #{@submission.claimant} (1)"
    expect(page).to have_text(part_three_result)

    select("Part II", from: "Part of Register")
    click_on("Apply Filter")

    expect(page).not_to have_text(part_three_result)

    select("Part III", from: "Part of Register")
    click_on("Apply Filter")

    expect(page).to have_text(part_three_result)
  end
end
