require "rails_helper"

describe "System Manager" do
  before do
    sign_in(create(:system_manager))
    visit("/")
  end

  scenario "finance pages" do
    expect(page).to have_link("Finance Team")
  end

  scenario "admin tools" do
    click_on("Part 3:")

    visit("/admin/users")
    expect(page).to have_css("h1", text: "User Management")
  end
end
