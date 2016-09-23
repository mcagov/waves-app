require "rails_helper"

describe "User views a registered vessel", type: :feature, js: true do
  before do
    create_completed_application!
    login_to_part_3
  end

  scenario "in general" do
    visit vessels_path
    click_on("Celebrator")

    expect(page).to have_css("h1", text: "Celebrator")

    click_on("People")
    within("#owner_1") do
      expect(page).to have_css(".owner-name", text: "Horatio Nelson")
    end
  end
end
