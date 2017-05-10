require "rails_helper"

describe "Manager views expiring certificates", js: true do
  before do
    @vessel = create(:registered_vessel)
    login_to_reports

    click_on("Expiring Certificates")
  end

  scenario "in general" do
    expect(page).to have_css("h1", text: "Reports: Expiring Certificates")
    expect(page).to have_css("th", text: "Vessel Name")
    expect(page).to have_css("th", text: "Certificate")
    expect(page).to have_css("th", text: "Expiry Date")
  end

  xscenario "filtering by date range" do
    date_range_result = @vessel.name
    within("#results") { expect(page).to have_text(date_range_result) }

    find("#filter_date_start").set("21/01/2017")
    find("#filter_date_end").set("22/01/2017")
    click_on("Apply Filter")

    within("#results") { expect(page).not_to have_text(date_range_result) }

    find("#filter_date_start").set("20/01/2017")
    find("#filter_date_end").set("22/01/2017")
    click_on("Apply Filter")

    within("#results") { expect(page).to have_text(date_range_result) }
  end

  xscenario "linking to a vessel page" do
    within("#results") { click_on(@vessel.name) }
    expect(page).to have_current_path(vessel_path(@vessel))
  end
end
