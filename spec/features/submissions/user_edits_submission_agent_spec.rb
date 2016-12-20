require "rails_helper"

describe "User edits submission agent", js: true do
  before do
    visit_assigned_submission

    click_on "Edit Application"
    click_on("Agent")
  end

  scenario "editing the agent" do
    click_on(Submission.last.agent.name)

    fill_in("Full Name", with: "ALICE AGENT")
    fill_in("Email Address", with: "alice@example.com")
    fill_in("Phone Number", with: "012345678")

    fill_in("Address 1", with: "Address 1")
    fill_in("Address 2", with: "Address 2")
    fill_in("Address 3", with: "Address 3")
    fill_in("Town or City", with: "Town")
    fill_in("Postcode", with: "POC123")
    select("SPAIN", from: "Country")
  end
end
