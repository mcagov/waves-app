require "rails_helper"

describe "Manager views advanced search", js: true do
  before do
    login_to_reports
    click_on("Advanced Search")
  end

  scenario "selecting the search criteria" do
    expect(page).to have_field("Vessel Name")

    name_operator = "filter[vessel[name_operator]]"
    name_field = "filter[vessel][name]"
    gt_operator = "filter[vessel[gross_tonnage_operator]]"

    find_field(name_operator).select("Excludes")
    find_field(name_field).set("Bob")
    find_field(gt_operator).select("Greater than")
    click_on("Apply Filter")

    expect(page).to have_select(name_operator, selected: "Excludes")
    expect(page).to have_field(name_field, with: "Bob")
    expect(page).to have_select(gt_operator, selected: "Greater than")
  end
end
