require "rails_helper"

describe "User edits vessel type", js: :true do
  scenario "in general" do
    visit_claimed_task(
      submission: create(:submission, :part_1_vessel),
      service: create(:service, :update_registry_details))

    select("DREDGER", from: "Vessel Category")
    expect(page).to have_css(".vessel_type_label", text: "Type of DREDGER")

    select("OIL TANKER", from: "Vessel Category")
    expect(page).to have_css(".vessel_type_label", text: "Type of OIL TANKER")
  end
end
