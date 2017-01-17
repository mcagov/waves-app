require "rails_helper"

describe "User save owner details", js: :true do
  scenario "Individual owner" do
    visit_name_approved_part_2_submission
    click_on("Owners & Shareholding")
    click_on("Add Individual Owner")

    fill_in("Name", with: "Bob")
    fill_in("IMO Number", with: "1234567")
    select("(b)", from: "Status")
    within(".declaration_declaration_signed") { choose("Yes") }
    click_on("Save Individual Owner")

    expect(page).to have_css(".owner-imo_number", text: "1234567")
    expect(page).to have_css(".owner-declaration", text: "Signed")

    expect(Submission.last.declarations.last.owner.eligibility_status.to_sym)
      .to eq(:status_b)
  end

  xscenario "Corporate owner" do
    visit_name_approved_part_2_submission
    click_on("Owners & Shareholding")
    click_on("Add Corporate Owner")

    fill_in("Name", with: "Bob Inc")
    fill_in("Registration Number", with: "1234567")
    fill_in("Date of Incorporation ", with: "12/01/2017")
    click_on("Save Individual Owner")

    expect(page).to have_css(".owner-registration_number", text: "1234567")
  end
end
