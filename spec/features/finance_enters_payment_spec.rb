require "rails_helper"

describe "Finance enters a payment" do
  before do
    login_to_finance
  end

  scenario "in its simplest form" do
    expect(page).to have_css(".active-register", text: "Active: Finance")
    expect(page).to have_css("h1", text: "Finance: Record Payment")

    select("Part III", from: "Part of Register")
    select("New Registration", from: "Application Type")
    fill_in("Official Number", with: "OFF_NO")
    fill_in("Vessel Name", with: "My Boat")

    select("Premium", from: "Service Level")
    select("Cheque", from: "Payment Type")
    fill_in("Fee Amount", with: "25.00")
    fill_in("Fee Receipt Number", with: "123")

    fill_in("Applicant Name", with: "Bob")
    fill_in("Applicant Email", with: "bob@example.com")
    fill_in("Documents Received", with: "bits and bobs")

    click_on("Save Application")

    expect(page).to have_css(".alert", "Application successfully saved")
  end
end
