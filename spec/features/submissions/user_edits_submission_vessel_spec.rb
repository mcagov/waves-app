require "rails_helper"

feature "User edits submission vessel", type: :feature, js: true do
  before { visit_assigned_submission }

  scenario "in a two column table" do
    expect(page).to have_css("table.submission-vessel th", count: 2)

    within("td#vessel-name") { click_on "Boaty McBoatface" }
    find(".editable-input input").set("Hop rod rye")
    first(".editable-submit").click
    expect(page).to have_css("td#vessel-name", text: "HOP ROD RYE")

    within("td#vessel-number_of_hulls") { click_on "5" }
    find(".editable-input select").select("3")
    first(".editable-submit").click
    expect(page).to have_css("td#vessel-number_of_hulls", text: "3")

    within("td#vessel-vessel_type") { click_on "BARGE" }
    find(".editable-input select").select("DINGHY")
    first(".editable-submit").click
    expect(page).to have_css("td#vessel-vessel_type", text: "DINGHY")

    vessel = Submission.last.vessel

    expect(vessel.name).to eq("HOP ROD RYE")
    expect(vessel.number_of_hulls).to eq("3")
    expect(vessel.vessel_type).to eq("DINGHY")
  end
end
