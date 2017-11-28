require "rails_helper"

describe "Manager views report: transfers in and out", js: true do
  before do
    @transfer_in = create(:completed_submission)
    @transfer_in.line_items.create(
      fee: build(:fee, task_variant: :transfer_from_bdt))

    @transfer_out = create(:completed_submission)
    @transfer_out.line_items.create(
      fee: build(:fee, task_variant: :transfer_to_bdt))

    login_to_reports

    click_on("Transfers In/Out")

    find("#filter_date_start").set(1.year.ago.to_s)
    find("#filter_date_end").set(1.year.from_now.to_s)
    click_on("Apply Filter")
  end

  scenario "in general" do
    expect_link_to_export_or_print(true)

    expect(page).to have_css("h1", text: "Reports: Transfers In/Out")

    page.all("table tr") do |tr|
      within(tr[0]) do
        expect(page).to have_css("th", text: "Name")
        expect(page).to have_css("th", text: "IMO Number")
        expect(page).to have_css("th", text: "Gross Tonnage")
        expect(page).to have_css("th", text: "Transfer date")
        expect(page).to have_css("th", text: "Status")
      end
    end

    # select Transfer In & test the results
  end

  scenario "linking to a vessel page" do
    within("#results") { click_on(@transfer_in.vessel.name) }
    expect(page)
      .to have_current_path(vessel_path(@transfer_in.registered_vessel))
  end
end
