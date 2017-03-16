require "rails_helper"

describe "User views Part 4 submission", type: :feature, js: true do
  scenario "UI elements" do
    visit_name_approved_part_4_submission
    expect_mortgages(false)
    expect_port_no_fields(false)
    expect_service_description_fields(false)
    expect_smc_fields(true)
    expect_last_registry_fields(false)
    expect_underlying_registry_fields(true)
  end

  scenario "Name Approval page" do
    visit_assigned_part_4_submission
    expect_port_no_fields(false)
  end
end
