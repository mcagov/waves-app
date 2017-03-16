require "rails_helper"

describe "User views Part 4 registered vessel", type: :feature, js: true do
  before do
    @vessel = create(:registered_vessel, part: :part_4)
    login_to_part_4
    visit vessels_path
    click_on(@vessel.name.upcase)
  end

  scenario "UI Elements" do
    expect_mortgages(false)
    expect_port_no_fields(false)
  end
end
