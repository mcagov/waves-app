require "rails_helper"

describe "User converts finance payment for existing vessel", js: true do
  before do
    vessel = create(:registered_vessel, name: "MY BOAT", hin: "PR-QNTIECMU3FVA")
    create(
      :submitted_finance_payment,
      part: :part_3,
      task: :renewal,
      vessel_reg_no: vessel.reg_no)

    login_to_part_3
    click_on("Fees Received")
  end

  scenario "checking the vessel attributes are populated in the changeset" do
    click_on("Claim")
    click_on("My Tasks")
    click_on("MY BOAT")
    within("#actions") { click_on("Convert to Application") }

    vessel = Submission.last.vessel
    expect(vessel.hin).to eq("PR-QNTIECMU3FVA")
    expect(vessel.name).to eq("MY BOAT")
  end
end
