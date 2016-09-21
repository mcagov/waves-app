require "rails_helper"

feature "User edits submission details", type: :feature, js: true do
  before { visit_assigned_submission }

  scenario "editing vessel details" do
    within("td#vessel-name") { click_on "Celebrator Doppelbock" }
    find(".editable-input input").set("Hop Rod Rye")
    first(".editable-submit").click
    expect(page).to have_css("td#vessel-name", text: "Hop Rod Rye")

    within("td#vessel-number_of_hulls") { click_on "5" }
    find(".editable-input select").select("3")
    first(".editable-submit").click
    expect(page).to have_css("td#vessel-number_of_hulls", text: "3")

    within("td#vessel-vessel_type") { click_on "barge" }
    find(".editable-input select").select("DINGHY")
    first(".editable-submit").click
    expect(page).to have_css("td#vessel-vessel_type", text: "DINGHY")

    vessel = Submission.last.vessel

    expect(vessel.name).to eq("Hop Rod Rye")
    expect(vessel.number_of_hulls).to eq("3")
    expect(vessel.vessel_type).to eq("DINGHY")
  end
end
