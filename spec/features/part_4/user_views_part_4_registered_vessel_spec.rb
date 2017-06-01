require "rails_helper"

describe "User views Part 4 registered vessel", type: :feature, js: true do
  before do
    @vessel = create(:registered_vessel, part: :part_4)
    login_to_part_4
    visit vessels_path
    click_on(@vessel.name.upcase)
  end

  scenario "UI Elements" do
    expect_ec_no(false)
    expect_charterers(true)
    expect_managers(false)
    expect_mortgages(false)
    expect_port_no_fields(false)
    expect_last_registry_fields(false)
    expect_service_description_fields(false)
    expect_smc_fields(true)
    expect_extended_engine_fields(false)
    expect_extended_owner_fields(false)
    expect_managing_owner_fields(false)
    expect_shareholding(false)
    expect_csr_forms(true)
  end
end
