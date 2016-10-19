require "rails_helper"

describe "User views a manual entry", type: :feature, js: true do
  before do
    create(:finance_payment, vessel_name: "MY BOAT", part: :part_1)
    login_to_part_1
    click_on("Unclaimed Tasks")
  end

  scenario "rendering the manual entry page" do
    click_on("MY BOAT")
    expect(page).to have_css("h1", "Manual Entry")
  end
end
