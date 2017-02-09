require "rails_helper"

describe "User edits shares held jointly", js: :true do
  before do
    visit_name_approved_part_2_submission
    click_on("Owners & Shareholding")

    @owner_name = Declaration.last.owner.name

    click_on("Add Group of Joint Shareholders")
    select(@owner_name, from: "Owner Name")
    click_on("Add Owner to New Group")
  end

  scenario "adding owners to a group of shareholders" do
    within("#shares_held_jointly") do
      expect(page).to have_css(".owner_name", text: @owner_name)
      expect(page).to have_css(".shares_held", text: "0")
    end

    second_owner_name =
      create(:declaration, submission: Submission.last).owner.name

    click_on("Add Owner to Group")
    within(".modal.fade.in") do
      select(second_owner_name, from: "Owner Name")
      click_on("Add Owner to Group")
    end

    within("#shares_held_jointly") do
      expect(page).to have_css(".owner_name", text: second_owner_name)
    end
  end

  scenario "removing an owner from a group" do
    within("#shares_held_jointly") do
      expect(page).to have_text(@owner_name)
      click_on("remove")
    end

    within("#shares_held_jointly") do
      expect(page).not_to have_text(@owner_name)
    end
    expect(Declaration::Group.count).to eq(0)
  end

  scenario "editing the number of shares" do
    expect(page).to have_css("#total_shares", text: "allocated: 0")

    within("#shares_held_jointly") { click_on("0") }
    find(".editable-input input").set("16")

    first(".editable-submit").click
    expect(page).to have_css("#total_shares", text: "allocated: 16")
  end
end
