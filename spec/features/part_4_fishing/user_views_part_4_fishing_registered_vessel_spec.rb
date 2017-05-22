require "rails_helper"

describe "User views Part 4 fishing vessel", type: :feature, js: true do
  before do
    @vessel = create(:part_4_fishing_vessel)
    login_to_part_4
    visit vessels_path
    click_on(@vessel.name.upcase)
  end

  scenario "UI Elements" do
    expect_ec_no(true)
    expect_charterers(true)
    expect_managers(false)
    expect_mortgages(false)
    expect_port_no_fields(true)
    expect_service_description_fields(true)
    expect_smc_fields(false)
    expect_extended_engine_fields(true)
    expect_extended_owner_fields(true)
    expect_shareholding(false)
    expect_csr_forms(false)
  end
end
