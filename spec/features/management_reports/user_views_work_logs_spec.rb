require "rails_helper"

describe "User views work logs", type: :feature do
  scenario "in general" do
    create(:work_log, created_at: "2010-12-11")
    create(:work_log, actioned_by: create(:user, name: "BOB"))
    create(:work_log, part: :part_4)

    login_to_reports

    visit work_logs_path
    expect(page).to have_css("#work_logs tbody tr", count: 3)

    select("Part IV", from: "Part of Register")
    click_on("Apply Filter")
    expect(page).to have_css("#work_logs tbody tr", count: 1)

    select("", from: "Part of Register")
    select("BOB", from: "Actioned By")
    click_on("Apply Filter")
    expect(page).to have_css("#work_logs tbody tr", count: 1)

    select("", from: "Actioned By")
    find_field("date_start").set("2010-12-10")
    find_field("date_end").set("2010-12-12")
    click_on("Apply Filter")
    expect(page).to have_css("#work_logs tbody tr", count: 1)
  end
end
