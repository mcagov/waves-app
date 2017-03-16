require "rails_helper"

describe "User views Part 1 submission", type: :feature, js: true do
  before do
    visit_name_approved_part_1_submission
  end

  scenario "tabs" do
    expect_mortgages(true)
    expect_port_no(false)
  end
end
