require "rails_helper"

describe "Operational user" do
  before do
    sign_in(create(:operational_user))
    visit("/")
  end

  scenario "finance pages" do
    expect(page).to have_link("Finance Team")
  end

  scenario "management reports" do
    expect(page).not_to have_link("Management Reports")

    visit("/admin/reports")
    expect(page).to have_http_status(401)
  end

  scenario "admin tools" do
    click_on("Part 3:")

    visit("/admin/users")
    expect(page).to have_http_status(401)
  end

  scenario "automated email queue"
end
