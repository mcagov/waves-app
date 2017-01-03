require "rails_helper"

describe "User searches" do
  before do
    login_to_part_3
  end

  scenario "searching by part of the submission ref_no" do
    create(:submission, ref_no: "ABC456")
    create(:submission, ref_no: "ABC123")
    create(:registered_vessel, name: "ABC FUN")

    within(".nav_menu") { search_for("ABC") }

    within("#search_results") do
      expect(page).to have_css("tr.submission", count: 2)
      expect(page).to have_css("tr.vessel", count: 1)
    end
  end

  scenario "searching by part of the vessel mmsi", js: true do
    vessel = create(:registered_vessel, mmsi_number: "232181282")
    create(:submission, registered_vessel: vessel)

    within(".nav_menu") { search_for("232181") }

    within("#search_results") do
      expect(page).to have_css("tr.vessel", count: 1)
      click_on("1 open application")
      expect(page).to have_css("tr.submission", count: 1)
    end
  end

  scenario "nothing found" do
    within(".nav_menu") { search_for("foo") }
    expect(page).to have_text("Nothing found")
  end
end
