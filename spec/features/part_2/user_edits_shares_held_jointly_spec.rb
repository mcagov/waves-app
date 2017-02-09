require "rails_helper"

describe "User edits shares held jointly", js: :true do
  scenario "adding owners to a group of shareholders" do
    visit_name_approved_part_2_submission
    owner_name = Declaration.last.owner.name

    click_on("Add Group of Joint Shareholders")
    select(owner_name, from: "Owner Name")
    click_on("Add Owner to New Group")

    within("#shares_held_jointly") do
      expect(page).to have_css(".owner_name", text: owner_name)
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
end
