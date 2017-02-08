require "rails_helper"

describe "User edits outright shares held", js: :true do
  scenario "with one owner" do
    visit_name_approved_part_2_submission

    expect(page).to have_css("#total_shares", text: "Total shares allocated: 0")
    within("#shares_held_outright") { click_on("0") }
  end
end
