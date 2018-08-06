require "rails_helper"

describe "User views application types" do
  before do
    login_to_part_3
  end

  scenario "in general" do
    click_on("Application Types")

    expect(page).to have_css("h1", text: "Application Types")
    expect(page).to have_css(".name", text: "New Registration")
  end
end
