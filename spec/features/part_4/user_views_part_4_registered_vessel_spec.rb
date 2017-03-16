require "rails_helper"

describe "User views Part 4 registered vessel", type: :feature, js: true do
  scenario "UI elements" do
    visit_name_approved_part_4_submission
    expect_mortgages(false)
    expect_port_no_fields(false)
  end

  scenario "Name Approval page" do
    visit_assigned_part_4_submission
    expect_port_no_fields(false)
  end
end
