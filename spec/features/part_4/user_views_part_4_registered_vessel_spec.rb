require "rails_helper"

describe "User views Part 4 registered vessel", type: :feature, js: true do
  before do
    @vessel = create(:registered_vessel, part: :part_4)
    login_to_part_4
    visit vessels_path
    click_on(@vessel.name.upcase)
  end

  scenario "tabs" do
    expect_mortgages(false)
    expect_port_no(false)
  end

  scenario "don't expect_port_no on name approval page"
end
