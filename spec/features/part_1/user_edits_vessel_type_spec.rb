require "rails_helper"

describe "User edits vessel type", js: :true do
  scenario "in general" do
    visit_name_approved_part_1_submission

    select("GENERAL CARGO SHIP", from: "Vessel Category")
    expect(page).to have_css(".vessel_type_label", text: "Type of GENERAL")

    select("BARGE", from: "Vessel Category")
    expect(page).to have_css(".vessel_type_label", text: "Type of BARGE")
  end
end
