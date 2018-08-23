require "rails_helper"

describe "User edits finance payment", type: :feature, js: true do
  before do
    create(:locked_finance_payment)
    visit_fee_entry
  end

  scenario "documents received" do
    within("#finance_info") { click_on("Edit Documents Received") }
    fill_in("Documents Received", with: "Excel file, C&M")
    click_button("Save")

    expect(page).to have_css("#documents-received", text: "Excel file, C&M")
  end

  scenario "changing the part of the registry" do
    within("#finance_info") { click_on("Edit Part of the Register") }

    select("Part IV", from: "Part of the Register")
    click_on("Save")

    expect(page).to have_text("The finance payment has been updated")
    expect(Payment::FinancePayment.last.part.to_sym).to eq(:part_4)
    expect(page).to have_current_path(unattached_payments_finance_payments_path)
  end
end
