require "rails_helper"

describe "User chooses registry part" do
  before { login }

  scenario "but when they don't we default to part_3" do
    visit "/tasks/unclaimed"
    expect(page).to have_css(".active-register", "Part III")
  end
end
