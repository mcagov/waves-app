require "rails_helper"

describe "User views autonomous vessels", js: true do
  before do
    create(:registered_vessel, :autonomous, name: "Audrey Autonomy")
    create(:registered_vessel, name: "Zero Autonomy")

    login_to_part_3
    visit "/part_3/work_logs/"
  end

  scenario "in general" do
    click_on("Autonomous Vessels")

    expect(page).to have_css("h1", text: "Autonomous Vessels")
    expect(page).to have_css("table#autonomous-vessels tbody tr", count: 1)
    expect(page).to have_css("td", text: "Audrey Autonomy")

    click_on("Export to Excel")
    sleep 1
    expect(page.response_headers["Content-Type"]).to match("application/xls")
    expect(page.text)
      .to match("Worksheet ss:Name=\"Autonomous Vessels\"")
  end
end
