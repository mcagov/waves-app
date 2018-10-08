require "rails_helper"

describe "User edits Directed & Controlled By", js: :true do
  scenario "in general" do
    visit_claimed_task(
      submission: create(:submission, :part_2_vessel),
      service: create(:service, :update_registry_details))

    click_on("Owners & Shareholding")
    click_on("Add Directed & Controlled By")

    within(".modal.fade.in") do
      expect_postcode_lookup
      fill_in("Name", with: "BOB BOLD")
      select("BELGIUM", from: "Nationality")
      click_on("Save")
    end

    expect(page).to have_css(".directed_by-name", text: "BOB BOLD")
    expect(page).to have_css(".directed_by-nationality", text: "BELGIUM")

    click_on("BOB BOLD")
    select("SPAIN", from: "Nationality")
    click_on("Save")

    expect(page).to have_css(".directed_by-nationality", text: "SPAIN")

    within("#directed_by") do
      click_on("Remove")
      expect(page).not_to have_css(".directed_by-name")
      expect(Submission.last.directed_bys).to be_empty
    end
  end
end
