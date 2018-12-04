require "rails_helper"

describe "User searches within finance payments" do
  before do
    login_to_finance
  end

  scenario "in general" do
    create(:finance_payment, payment_reference: "ABC456")
    create(:finance_payment, payment_reference: "ABC123")

    within(".nav_menu") { search_for("ABC") }

    within("#finance-payments") do
      expect(page).to have_css("tr.finance-payment", count: 2)
    end
  end
end
