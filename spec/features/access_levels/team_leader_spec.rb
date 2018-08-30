require "rails_helper"

describe "Team leader" do
  before do
    sign_in(create(:team_leader))
    visit("/")
  end

  scenario "finance pages" do
    expect(page).to have_link("Finance Team")
  end

  scenario "admin tools" do
    click_on("Part 3:")

    visit("/admin/users")
    expect(page).to have_http_status(401)
  end
end
