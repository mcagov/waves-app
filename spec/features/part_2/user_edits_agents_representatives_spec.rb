require "rails_helper"

describe "User edits submission agent", js: true do
  before do
    visit_name_approved_part_2_submission
    click_on("Agents & Representative Persons")
  end

  scenario "checking the agent fields are displayed" do
    expect(page).to have_css("#agent_list td.agent-name", count: 1)
    expect(page).to have_css("#agent_modal")
  end
end
