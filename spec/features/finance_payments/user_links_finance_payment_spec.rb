require "rails_helper"

describe "User links finance_payment", type: :feature, js: true do
  before do
    vessel_reg_no = create(:registered_vessel).reg_no

    create(
      :submission,
      part: :part_3,
      vessel_reg_no: vessel_reg_no,
      task: :change_owner,
      ref_no: "ABC123")

    create(
      :submission,
      part: :part_3,
      vessel_reg_no: vessel_reg_no,
      task: :change_vessel,
      ref_no: "FOOBAR")

    create(
      :finance_payment,
      part: :part_3,
      task: :new_registration,
      application_ref_no: "ABC123")

    claim_submission_and_visit
  end

  scenario "to the prompted application" do
    expect(page)
      .to have_css("h1", text: "New Registration ID: Not yet generated")

    within("td.official_no") { expect(page).not_to have_link("Change") }

    within("#actions") { click_on("Link to Application") }

    expect(page).to have_css("h1", text: "Change of Ownership ID: ABC123")
  end

  scenario "to another application" do
    within("#actions") { click_on("Link to Another Application") }

    within("#link-application") do
      search_for("foo")
      within("#submissions") { click_on("Link") }
    end

    expect(page)
      .to have_css("h1", text: "Change of Vessel details ID: FOOBAR")
  end
end
