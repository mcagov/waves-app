require "rails_helper"

describe "User views Part 1 submission", type: :feature, js: true do
  scenario "UI elements" do
    visit_name_approved_part_1_submission
    expect_charterers(false)
    expect_mortgages(true)
    expect_port_no_fields(false)
    expect_last_registry_fields(true)
    expect_underlying_registry_fields(false)
    expect_service_description_fields(false)
    expect_smc_fields(true)
    expect_extended_engine_fields(false)
    expect_extended_owner_fields(false)
  end

  scenario "Name Approval page" do
    visit_assigned_part_1_submission
    expect_port_no_fields(false)
  end
end
