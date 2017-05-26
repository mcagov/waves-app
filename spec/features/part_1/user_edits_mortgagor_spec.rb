require "rails_helper"

describe "User edits mortgagors", js: :true do
  scenario "adding an owner, then adding that owner as a mortgagor" do
    visit_name_approved_part_1_submission
    click_on("Owners")
    click_on("Add Individual Owner")

    fill_in("Name", with: "BOB BOLD")
    fill_in("Address 1", with: "10 Downing St")
    click_on("Save Individual Owner")

    click_on("Mortgages")
    click_on("Add Mortgage")

    within("#mortgagors") do
      expect(page).to have_field("Name of Mortgagor")
      select("BOB BOLD", from: "Select an Owner")
      expect(page).not_to have_field("Name of Mortgagor")
    end
  end
end
