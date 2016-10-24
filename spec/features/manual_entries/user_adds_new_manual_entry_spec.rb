require "rails_helper"

describe "User adds a new manual entry", type: :feature do
  before do
    login_to_part_3
    visit new_submission_path
  end

  scenario "for a change of ownership" do
    select("Change of Ownership", from: "Application Type")
    click_on("Save Application")

    expect(page).to have_css(".breadcrumb", text: "My Tasks")
    expect(page).to have_css("h1", text: "Change of Ownership")
  end
end
