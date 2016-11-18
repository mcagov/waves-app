require "rails_helper"

describe "Finance enters a payment", type: :feature do
  before do
    login_to_finance
  end

  scenario "in its simplest form" do
    expect(page).to have_css(".active-register", text: "Active: Finance")
    expect(page).to have_css("h1", text: "Finance: Fee Entry")

    select("Part III", from: "Part of Register")
    fill_in("Fee Receipt Date", with: "12/12/2012")
    select("New Registration", from: "Task Type")

    fill_in("Reference Number", with: "")
    fill_in("Official Number", with: "")
    fill_in("Vessel Name", with: "MY BOAT")

    select("Cheque", from: "Payment Type")
    fill_in("Fee Amount", with: "25")
    fill_in("Fee Receipt Number", with: "Fee receipt no")

    fill_in("Applicant Name", with: "BOB")
    fill_in("Applicant Email", with: "bob@example.com")
    fill_in("Documents Received", with: "bits and bobs")

    click_on("Save Application")

    expect(page).to have_css(".alert", text: "Payment successfully recorded")

    within("#finance_payment") do
      expect(page).to have_text("12/12/2012")
      expect(page).to have_text("Part III")
      expect(page).to have_text("New Registration")
      expect(page).to have_text("MY BOAT")
      expect(page).to have_text("Cheque")
      expect(page).to have_text("25.00")
      expect(page).to have_text("Fee receipt no")
      expect(page).to have_text("BOB")
      expect(page).to have_text("bob@example.com")
      expect(page).to have_text("bits and bobs")
    end

    expect(Notification::PaymentReceipt.count).to eq(1)
  end
end
