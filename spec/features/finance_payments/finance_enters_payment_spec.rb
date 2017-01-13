require "rails_helper"

describe "Finance enters a payment", type: :feature do
  before do
    login_to_finance
    click_on("Start a Batch")
  end

  scenario "in its simplest form" do
    expect(page).to have_css(".active-register", text: "Active: Finance")
    expect(page).to have_css("h1", text: "Finance: Fee Entry")
    expect(page).to have_text("Batch: #{FinanceBatch.last.batch_no}")

    fill_in("Fee Receipt Date", with: "12/12/2012")
    fill_in("Application Reference No", with: "ABC123")

    select("Part III", from: "Part of the Register")
    select("New Registration", from: "Application Type")

    fill_in("Official No.", with: "")
    fill_in("Vessel Name", with: "MY BOAT")

    fill_in("Payer Name", with: "PERCIVAL")
    select("CHQ", from: "Payment Type")
    fill_in("Fee Amount", with: "25")

    fill_in("Applicant Name", with: "BOB")
    fill_in("Applicant's Email Address", with: "bob@example.com")
    check("Applicant is Agent")

    fill_in("Documents Received", with: "bits and bobs")

    click_on("Save Fee Entry")

    expect(page).to have_css(
      ".alert",
      text: "Fee entry successfully recorded")

    within("#finance_payment") do
      expect(page).to have_text("12/12/2012")
      expect(page).to have_text("ABC123")
      expect(page).to have_text("Part III")
      expect(page).to have_text("New Registration")
      expect(page).to have_text("MY BOAT")
      expect(page).to have_text("PERCIVAL")
      expect(page).to have_text("CHQ")
      expect(page).to have_text("25.00")
      expect(page).to have_text("BOB (Agent)")
      expect(page).to have_text("bob@example.com")
      expect(page).to have_text("bits and bobs")
    end
  end

  scenario "creating and then editing on the index page" do
    fill_in("Fee Amount", with: "25")
    click_on("Save Fee Entry")

    click_on("Batch #{FinanceBatch.last.batch_no}")
    click_on("£25.00")

    fill_in("Fee Amount", with: "50")
    click_on("Update Fee Entry")

    expect(page).to have_css(
      ".alert",
      text: "Fee entry successfully updated")

    expect(page).to have_link("£50.00")
  end
end
