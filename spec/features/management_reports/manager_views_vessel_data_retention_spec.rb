require "rails_helper"

describe "Manager views vessel data retention reports", js: true do
  before do
    @scrubbable_vessel =
      create(
        :registered_vessel,
        mortgages: [build(:mortgage, :discharged)],
        scrubbed_at: nil,
        scrubbable: true)

    @req_expired =
      @scrubbable_vessel.current_registration.registered_until

    @mortgage_expired =
      @scrubbable_vessel.latest_discharged_mortgage.discharged_at

    @scrubbed_vessel =
      create(:registered_vessel, scrubbed_at: 1.day.ago, scrubbable: true)

    @vessel = create(:registered_vessel)

    login_to_reports

    click_on("Vessel Data Retention")
  end

  scenario "in general" do
    expect_link_to_export_or_print(false)
    expect(page).to have_css("h1", text: "Reports: Vessel Data Retention")

    within("#results") do
      expect(page).to have_css("th", text: "Name")
      expect(page).to have_css("th", text: "Official No")
      expect(page).to have_css("th", text: "Registration Expired")
      expect(page).to have_css("th", text: "Last Mortgage Discharged")

      expect(page).to have_css("tbody tr", count: 1)
      expect(page).to have_css("td", text: @scrubbable_vessel.name)
      expect(page).to have_css("td", text: @scrubbable_vessel.reg_no)
      expect(page).to have_css("td", text: @req_expired)
      expect(page).to have_css("td", text: @mortgage_expired)
    end
  end

  scenario "linking to a vessel page" do
    within("#results") { click_on(@scrubbable_vessel.name) }
    expect(page).to have_current_path(vessel_path(@scrubbable_vessel))
  end
end
