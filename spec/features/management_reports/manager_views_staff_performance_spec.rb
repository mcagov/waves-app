require "rails_helper"

describe "Manager views staff performance report", js: true do
  let!(:missed_in_part_3) do
    create(:staff_performance_log,
           part: :part_3,
           target_date: "19/01/2017",
           created_at: "20/01/2017")
  end

  before do
    login_to_reports

    click_on("Staff Performance")
  end

  scenario "in general" do
    expect_link_to_export_or_print(true)

    expect(page).to have_css("h1", text: "Reports: Staff Performance")
    expect(page).to have_css("th", text: "Task Type")
    expect(page).to have_css("th", text: "Total Transactions")
    expect(page).to have_css("th", text: "Within Service Standard")
    expect(page).to have_css("th", text: "Standard Missed")
  end

  scenario "filtering by part" do
    expect(page).to have_css("#results .red", text: 1)

    select("Part II", from: "Part of Register")
    click_on("Apply Filter")

    expect(page).not_to have_css("#results .red")

    select("Part III", from: "Part of Register")
    click_on("Apply Filter")

    expect(page).to have_css("#results .red", text: 1)
  end

  scenario "filtering by date range" do
    expect(page).to have_css("#results .red", text: 1)

    find("#filter_date_start").set("21/01/2017")
    find("#filter_date_end").set("22/01/2017")
    click_on("Apply Filter")

    expect(page).to have_css("#results .red", text: 0)

    find("#filter_date_start").set("20/01/2017")
    find("#filter_date_end").set("22/01/2017")
    click_on("Apply Filter")

    expect(page).to have_css("#results .red", text: 1)
  end

  scenario "downloading the xls version" do
    click_on("Export to Excel")
    sleep 1
    expect(page.response_headers["Content-Type"]).to match("application/xls")
    expect(page.text).to match("Worksheet ss:Name=\"Staff Performance\"")
  end

  xscenario "viewing the sub report with an existing filter" do
    select("Part II", from: "Part of Register")
    find("#filter_date_start").set("21/01/2017")
    click_on("Apply Filter")

    within("#results") { click_on("Demo Service") }

    expect(find("#filter_task").value).to eq("re_registration")
    expect(find("#filter_part").value).to eq("part_2")
    expect(find("#filter_date_start").value).to eq("21/01/2017")
    expect(page)
      .to have_css("h1", text: "Reports: Staff Performance by Task")
  end
end
