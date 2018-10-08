require "rails_helper"

describe "Manager views report: transfers out", js: true do
  let!(:closed_vessel) { create(:closed_vessel) }

  before do
    login_to_reports
    click_on("Transfers Out")

    find("#filter_date_start").set(1.year.ago.to_s)
    find("#filter_date_end").set(1.year.from_now.to_s)
    click_on("Apply Filter")
  end

  scenario "in general" do
    expect_link_to_export_or_print(true)
    expect(page).to have_css("h1", text: "Reports: Transfers Out")

    within("table thead tr") do
      expect(page).to have_css("th", text: "Name")
      expect(page).to have_css("th", text: "Part")
      expect(page).to have_css("th", text: "IMO Number")
      expect(page).to have_css("th", text: "Gross Tonnage")
      expect(page).to have_css("th", text: "Date Registration Closed")
    end

    within("table tbody tr") do
      expect(page).to have_css("td", text: closed_vessel.name)
      expect(page).to have_css("td", text: "Part 3")
      expect(page).to have_css("td", text: closed_vessel.imo_number)
      expect(page).to have_css("td", text: closed_vessel.gross_tonnage)
      closed_at = closed_vessel.current_registration.closed_at
      expect(page).to have_css("td", text: closed_at)

      click_on(closed_vessel.name)
    end

    expect(page).to have_current_path(vessel_path(closed_vessel))
  end
end
