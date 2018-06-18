require "rails_helper"

describe "User links finance_payment", type: :feature, js: true do
  before do
    vessel_reg_no = create(:registered_vessel).reg_no

    create(
      :submission,
      part: :part_3,
      vessel_reg_no: vessel_reg_no,
      document_entry_task: :change_owner,
      ref_no: "ABC123")

    create(
      :submission,
      part: :part_3,
      vessel_reg_no: create(:registered_vessel).reg_no,
      document_entry_task: :change_vessel,
      ref_no: "FOOBAR")

    create(
      :locked_finance_payment,
      part: :part_3,
      task: :new_registration,
      application_ref_no: "ABC123")

    visit_fee_entry
  end

  xscenario "to the prompted application" do
    expect(page).to have_css("h1", text: "Fee Received")

    within("#actions") { click_on("Link to an Open Application") }

    expect(page)
      .to have_css("h1", text: /Change of Ownership for .* ID: ABC123/)
  end

  xscenario "to another application" do
    within("#actions") { click_on("Link to Another Application") }

    within("#link-application") do
      search_for("foo")
      within("#submissions") { click_on("Link") }
    end

    expect(page)
      .to have_css("h1", text: /Change of Vessel details .* ID: FOOBAR/)
  end

  xscenario "unlinking the application" do
    within(".linkable_ref_no") { click_on("Unlink") }
    within("#actions") { expect(page).to have_link("Convert to Application") }
  end
end
