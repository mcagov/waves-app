require "rails_helper"

describe "Read only user" do
  before do
    create(:registered_vessel, name: "READONLY BOAT")
    sign_in(create(:read_only_user))
    visit("/")
  end

  scenario "in general" do
    click_on("Part 3:")
    expect(page).to have_current_path("/vessels")
    expect(page).not_to have_css(".side-menu")

    click_on("READONLY BOAT")
    expect(page).not_to have_link("Registrar Tools")
  end
end
