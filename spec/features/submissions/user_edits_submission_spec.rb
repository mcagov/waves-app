require "rails_helper"

describe "User edits a submission", js: true do
  before do
    visit_assigned_submission
    click_on "Edit Application"
  end

  scenario "removing Alice, then Adding Bob " do
    click_on("Owners")
    click_on("Remove Owner")
    click_on("Add Individual Owner")

    fill_in("Owner Name", with: "Bob")
    click_on("Save Application")

    click_on("Owners")
    expect(page).to have_css("#declaration_1 .owner-name", text: "BOB")
  end
end
