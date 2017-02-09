require "rails_helper"

describe "User edits shares held jointly", js: :true do
  scenario "with one owner" do
    visit_name_approved_part_2_submission

    owner_name = Declaration.last.owner.name
    click_on("Add Group of Joint Shareholders")
    select(owner_name, from: "Owner Name")
    click_on("Add Owner to New Group")

    expect(Declaration::Group.count).to eq(1)
  end
end
