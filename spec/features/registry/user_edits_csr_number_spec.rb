require "rails_helper"

describe "User edits CSR number", type: :feature, js: true do
  before do
    login_to_part_1
    vessel = create(:merchant_vessel)
    vessel.csr_forms.map do |csr_form|
      csr_form.update_attribute(:issue_number, 5)
    end

    visit vessel_path(vessel)
    click_on("CSRs")
  end

  scenario "in general" do
    within(".issue-number") do
      click_on("5")
      fill_in("CSR Number", with: "7")
      click_on("Save")
    end

    expect(page).to have_css(".issue-number", text: "7")
  end
end
