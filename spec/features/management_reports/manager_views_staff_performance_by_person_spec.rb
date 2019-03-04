require "rails_helper"

describe "Manager views staff performance report by person", js: true do
  let!(:alice) { create(:system_manager, name: "Alice") }
  let!(:task) { create(:task) }

  let!(:missed_in_part_3) do
    create(:staff_performance_log,
           part: :part_3,
           target_date: "19/01/2017",
           created_at: "20/01/2017",
           actioned_by: alice,
           task: task,
           service_id: task.service_id)
  end

  before do
    create(:service, name: "Random Service")
    login_to_reports(alice)

    click_on("Staff Performance by Task")
    within("#results") { click_on("Alice") }
  end

  scenario "in general" do
    expect_link_to_export_or_print(true)

    expect(page).to have_css("h1", text: "Performance by Member of Staff")
    expect(page).to have_css("th", text: "Task Type")
    expect(page).to have_css("th", text: "Application")
    expect(page).to have_css("th", text: "Activity")
    expect(page).to have_css("th", text: "Service Level")
    expect(page).to have_css("th", text: "Date Received")
    expect(page).to have_css("th", text: "Target Date")
    expect(page).to have_css("th", text: "Date Actioned")
  end

  scenario "filtering by part" do
    expect_result

    select("Part II", from: "Part of Register")
    click_on("Apply Filter")

    dont_expect_result

    select("Part III", from: "Part of Register")
    click_on("Apply Filter")

    expect_result
  end

  scenario "filtering by date range" do
    expect_result

    find("#filter_date_start").set("21/01/2017")
    find("#filter_date_end").set("22/01/2017")
    click_on("Apply Filter")

    dont_expect_result

    find("#filter_date_start").set("20/01/2017")
    find("#filter_date_end").set("22/01/2017")
    click_on("Apply Filter")

    expect_result
  end

  scenario "filtering by service" do
    expect_result

    select("Demo Service", from: "Service")
    click_on("Apply Filter")
    expect_result

    select("Random Service", from: "Service")
    click_on("Apply Filter")
    dont_expect_result
  end
end

def expect_result
  expect(page).to have_css("#results tbody tr", count: 1)
end

def dont_expect_result
  expect(page).not_to have_css("#results tbody tr")
end
