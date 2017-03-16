require "rails_helper"

describe "User views Part 1 registered vessel", type: :feature, js: true do
  before do
    @vessel =
      create(:registered_vessel, part: :part_1, vessel_category: "BARGE")

    login_to_part_1
    visit vessel_path(@vessel)
  end

  scenario "in general" do
    expect(page).to have_css("#vessel_type_label", text: "Type of BARGE")

    expect_mortgages(true)
    expect_port_no(false)
  end
end
