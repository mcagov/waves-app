require "rails_helper"

describe "User checks target dates" do
  scenario "in its simplest form" do
    login_to_part_3
    visit target_dates_path
    expect(page).to have_css("h1", text: "Target Date Calculator")

    select("31", from: "start_date_day")
    select("October", from: "start_date_month")
    select("2015", from: "start_date_year")

    click_on("Calculate")
    expect(find_field("start_date_day").value).to eq "31"
    expect(find_field("start_date_month").value).to eq "10"
    expect(find_field("start_date_year").value).to eq "2015"
  end
end
