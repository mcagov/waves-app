require "rails_helper"

describe "User edits CSR", type: :feature, js: true do
  let!(:vessel) { create(:merchant_vessel) }

  before do
    login_to_part_1
    vessel.csr_forms.map do |csr_form|
      csr_form.update_attribute(:issue_number, 5)
    end

    visit vessel_path(vessel)
    click_on("CSRs")
  end

  scenario "number" do
    within(".issue-number") do
      click_on("5")
      fill_in("CSR Number", with: "7")
      click_on("Save")
    end

    expect(page).to have_css(".issue-number", text: "7")
  end

  scenario "in general" do
    within("#csr_forms") do
      click_on("Edit CSR Form")
    end

    find_field("csr_form[vessel_name]").set("NEW NAME")
    click_on("Save")

    expect(page).to have_current_path(vessel_path(vessel.id))
    expect(vessel.reload.csr_forms.last.vessel_name).to eq("NEW NAME")
  end
end
