require "rails_helper"

describe "User views Part 4 submission", type: :feature, js: true do
  before do
    visit_name_approved_part_4_submission
  end

  scenario "UI Elements" do
    expect_mortgages(false)
    expect_port_no_fields(false)
    expect_service_description_fields(false)
    expect_last_registry_fields(false)
    expect_underlying_registry_fields(true)
  end
end
