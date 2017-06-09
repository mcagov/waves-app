require "rails_helper"

describe "Manager views advanced search", js: true do
  before do
    create(:registered_vessel, name: "BOB", gross_tonnage: 1.0)
    create(:registered_vessel, name: "SOMEONE ELSE", gross_tonnage: 12345)
    login_to_reports
    click_on("Advanced Search")
  end

  scenario "selecting the search criteria" do
    expect(page).to have_css("#results th", text: "Vessel Name")
    expect(page).to have_field("Vessel Name")
    expect(page).to have_css("#results tr td", text: "BOB")

    # remove the vessel name field
    name_fields = "#fields_vessel_name"
    within(name_fields) do
      find(:css, "a.hide_search_criteria").trigger("click")
    end
    expect(page).not_to have_css(name_fields)

    # restore the vessel name field and add the gross tonnage field
    within("#filter_vessel") do
      find_field("add_criteria[show_vessel]").select("Vessel Name")
      find_field("add_criteria[show_vessel]").select("Gross Tonnage")
    end

    name_operator = "filter[vessel[name][operator]]"
    name_field = "filter[vessel][name][value]"
    name_displayed = "filter_vessel_name_result_displayed"
    gt_operator = "filter[vessel[gross_tonnage][operator]]"
    gt_field = "filter[vessel][gross_tonnage][value]"
    gt_displayed = "filter_vessel_gross_tonnage_result_displayed"

    find_field(name_operator).select("Excludes")
    find_field(name_displayed).set(false)
    find_field(name_field).set("RABBIT")
    find_field(gt_operator).select("Greater than")
    find_field(gt_field).set("10")
    find_field(gt_displayed).set(true)

    # ensure that the selections persist when the form is submitted
    click_on("Apply Filter")
    expect(page).to have_select(name_operator, selected: "Excludes")
    expect(page).to have_field(name_field, with: "RABBIT")
    expect(find_field(name_displayed)).not_to be_checked
    expect(page).to have_select(gt_operator, selected: "Greater than")
    expect(page).to have_field(gt_field, with: "10")
    expect(page).to have_css("#results th", text: "Gross Tonnage")

    expect(page).to have_css("#results tr td", text: "12345")
  end
end
