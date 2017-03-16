require "rails_helper"

describe "User views Part 2 submission", type: :feature, js: true do
  scenario "UI elements" do
    visit_name_approved_part_2_submission
    expect_mortgages(true)
    expect_port_no_fields(true)
  end

  scenario "Name Approval page" do
    visit_assigned_part_2_submission
    expect_port_no_fields(true)
  end
end
