require "rails_helper"

describe "Manager views report: transfers in", js: true do
  let!(:registered_vessel) { create(:registered_vessel) }

  before do
    login_to_reports
    click_on("Transfers In")

    find("#filter_date_start").set(1.year.ago.to_s)
    find("#filter_date_end").set(1.year.from_now.to_s)
    click_on("Apply Filter")
  end

  scenario "in general" do
    expect_link_to_export_or_print(true)
    expect(page).to have_css("h1", text: "Reports: Transfers In")

    within("table thead tr") do
      expect(page).to have_css("th", text: "Name")
      expect(page).to have_css("th", text: "Part")
      expect(page).to have_css("th", text: "IMO Number")
      expect(page).to have_css("th", text: "Gross Tonnage")
      expect(page).to have_css("th", text: "Date Registered")
    end

    within("table tbody tr") do
      expect(page).to have_css("td", text: registered_vessel.name)
      expect(page).to have_css("td", text: "Part 3")
      expect(page).to have_css("td", text: registered_vessel.imo_number)
      expect(page).to have_css("td", text: registered_vessel.gross_tonnage)
      registered_at = registered_vessel.first_registration.registered_at
      expect(page).to have_css("td", text: registered_at)

      click_on(registered_vessel.name)
    end

    expect(page).to have_current_path(vessel_path(registered_vessel))
  end
end
