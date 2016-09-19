require "rails_helper"

feature "User edits submission details", type: :feature, js: true do
  before { visit_assigned_submission }

  scenario "editing vessel details" do
    within("td#vessel-name") { click_on "Celebrator Doppelbock" }
    find(".editable-input input").set("Hop Rod Rye")
    first(".editable-submit").click

    expect(page).to have_css("td#vessel-name", text: "Hop Rod Rye")

    # while we know that the page is displaying the updated value
    # we will do a "hard" test to be sure that value is persisted
    expect(Submission.last.vessel.name).to eq("Hop Rod Rye")

    within("td#vessel-hin") { click_on "PR-QNTIECMU3FVA" }
    find(".editable-input input").set("ABCD")
    first(".editable-submit").click

    expect(page).to have_css("td#vessel-hin", text: "ABCD")

    within("td#vessel-make_and_model") { click_on "Makey McMakeface" }
    find(".editable-input input").set("NEW MAKE")
    first(".editable-submit").click

    expect(page).to have_css("td#vessel-make_and_model", text: "NEW MAKE")

    within("td#vessel-length_in_meters") { click_on "11.51" }
    find(".editable-input input").set("10.11")
    first(".editable-submit").click

    expect(page).to have_css("td#vessel-length_in_meters", text: "10.11")

    within("td#vessel-mmsi_number") { click_on "233878594" }
    find(".editable-input input").set("111111111")
    first(".editable-submit").click

    expect(page).to have_css("td#vessel-mmsi_number", text: "111111111")

    within("td#vessel-radio_call_sign") { click_on "4RWO0K" }
    find(".editable-input input").set("AM123")
    first(".editable-submit").click

    expect(page).to have_css("td#vessel-radio_call_sign", text: "AM123")
  end

  it "shows number of hulls as a select"
  it "shows vessel type as a select"
  it "edits owners"
end
