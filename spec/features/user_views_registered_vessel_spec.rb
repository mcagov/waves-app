require "rails_helper"

describe "User views a registered vessel", type: :feature, js: true do
  before do
    create(:register_vessel, name: "Jolly Roger")
    login_to_part_3
  end

  scenario "in general" do
    visit vessels_path
    click_on("Jolly Roger")

    expect(page).to have_css("h1", text: "Jolly Roger")
  end
end
