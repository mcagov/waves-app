require "rails_helper"

describe "Finance enters a payment batch" do
  before do
    login_to_finance
  end

  scenario "in its simplest form" do
    expect(page).to have_css(".active-register", text: "Active: Finance")
    expect(page).to have_css("h1", text: "Finance: Batch Payments")
  end
end
