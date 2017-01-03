require "rails_helper"

describe "User edits submission signature" do
  before do
    create(:registered_vessel, reg_no: "SSR200001")
    visit_assigned_submission
    click_on("New Registration ID: ")
  end

  scenario "changing the task type" do
    select("Change of Vessel details", from: "Application Type")
    fill_in("Official No.", with: "SSR200001")
    click_on("Save")

    expect(page).to have_css("h1", text: "Change of Vessel details ID")
  end

  scenario "changing the part of the registry"
end
