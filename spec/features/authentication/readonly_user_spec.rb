require "rails_helper"

describe "Read only user" do
  before do
    sign_in(create(:read_only_user))
    visit("/")
  end

  scenario "in general" do
    click_on("Part 1: Pleasure")
    expect(page).to have_current_path("/vessels")
    expect(page).not_to have_css(".side-menu")
  end
end
