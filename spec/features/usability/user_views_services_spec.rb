require "rails_helper"

describe "User views services" do
  before do
    create(:demo_service)
    login_to_part_3
    visit admin_services_path
  end

  scenario "in general" do
    expect(page).to have_css(".service-name", text: "Demo Service")
  end
end
