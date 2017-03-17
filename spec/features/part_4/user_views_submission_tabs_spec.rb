require "rails_helper"

describe "User views Part 4 submission", type: :feature, js: true do
  before do
    visit_name_approved_part_4_submission
  end

  scenario "tabs" do
    expect_mortgages(false)
    expect_managers(false)
  end
end
