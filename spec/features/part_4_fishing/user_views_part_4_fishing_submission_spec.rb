require "rails_helper"

describe "User views Part 4 fishing submission", type: :feature, js: true do
  before do
    visit_name_approved_part_4_fishing_submission
  end

  scenario "UI Elements" do
    expect_charterers(true)
    expect_mortgages(false)
    expect_port_no_fields(true)
    expect_service_description_fields(true)
    expect_smc_fields(false)
    expect_last_registry_fields(false)
    expect_underlying_registry_fields(true)
    expect_basic_engine_fields(false)
  end
end
