require "rails_helper"

describe "Finance views batches", type: :feature, js: true do
  before do
    3.times { create(:finance_payment) }
    login_to_finance
  end

  scenario "in general" do
    click_link("All Batches")
    expect(page).to have_css("h1", text: "Finance: All Batches")
    expect(page).to have_css("tr.batch", count: 3)

    click_link("Batches This Week")
    expect(page).to have_css("h1", text: "Finance: Batches This Week")
    expect(page).to have_css("tr.batch", count: 3)

    click_link("Batches This Month")
    expect(page).to have_css("h1", text: "Finance: Batches This Month")
    expect(page).to have_css("tr.batch", count: 3)

    click_link("Batches This Year")
    expect(page).to have_css("h1", text: "Finance: Batches This Year")
    expect(page).to have_css("tr.batch", count: 3)
  end
end
