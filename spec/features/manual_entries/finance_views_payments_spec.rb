require "rails_helper"

describe "Finance views payments", type: :feature, js: true do
  before do
    3.times { create(:finance_payment) }
    login_to_finance
    click_on("Recent Payments")
  end

  scenario "as a list of 3 items" do
    expect(page).to have_css("tr.finance-payment", count: 3)
  end
end
