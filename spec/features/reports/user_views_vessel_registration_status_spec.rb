require "rails_helper"

describe "User views vessel registration status", js: true do
  before do
    @vessel = create(:registered_vessel)
    login_to_part_3
    find("a.reports_menu").click
    click_on("Vessel Registration Status")
  end

  scenario "in general" do
    expect(page).to have_css("h1", text: "Reports: Vessel Registration Status")
    expect(page).to have_css("th", text: "Name")
    expect(page).to have_css("th", text: "Official No")
    expect(page).to have_css("th", text: "Radio Call Sign")
    expect(page).to have_css("th", text: "Expiration Date")
    expect(page).to have_css("th", text: "Status")
  end
end
