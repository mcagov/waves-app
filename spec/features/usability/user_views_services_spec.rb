require "rails_helper"

describe "User views services" do
  before do
    create(:demo_service, :validates_on_approval)
    login_to_part_3
  end

  scenario "prices" do
    click_on("Service Prices")

    expect(page).to have_css("h1", text: "Service Prices")
    expect(page).to have_css(".service-name", text: "Demo Service")
    expect(page).to have_css(".prices", text: "Standard: £124.00")
  end

  scenario "processes" do
    click_on("Service Processes")

    expect(page).to have_css("h1", text: "Service Processes")
    expect(page).to have_css(".service-name", text: "Demo Service")
    expect(page).to have_css(".rules", text: "Validates on approval")
  end
end
