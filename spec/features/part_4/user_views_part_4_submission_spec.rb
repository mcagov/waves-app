require "rails_helper"

describe "User views Part 4 submission", type: :feature, js: true do
  scenario "UI elements" do
    visit_claimed_task(
      service: create(:service, :update_registry_details),
      submission: create(:submission, :part_4_vessel))

    expect_safety_certificate_warning(false)
    expect_ec_no(false)
    expect_charterers(true)
    expect_mortgages(false)
    expect_managers(true)
    expect_port_no_fields(false)
    expect_service_description_fields(false)
    expect_smc_fields(true)
    expect_last_registry_fields(false)
    expect_underlying_registry_fields(true)
    expect_extended_engine_fields(false)
    expect_extended_owner_fields(false)
    expect_managing_owner_fields(false)
    expect_shareholding(false)
    expect_owner_declarations(false)
    expect_payments_tab(true)
  end
end
