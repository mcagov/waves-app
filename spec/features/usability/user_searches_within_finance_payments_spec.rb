require "rails_helper"

describe "User searches within finance payments" do
  let!(:payment) { create(:payment, submission: create(:submission)) }

  let!(:finance_payment) do
    create(:locked_finance_payment,
           payment_reference: "ABC456",
           payment_date: "21/01/2017",
           payment: payment)
  end

  before do
    login_to_finance
    within(".nav_menu") { search_for("ABC") }
  end

  scenario "in general" do
    within("#finance-payments") do
      expect(page).to have_css("tr.finance-payment", count: 1)
    end
  end

  scenario "filtering by part" do
    select("Part III", from: "Part of Register")
    click_on("Apply Filter")
    expect(page).to have_css(results_row_css, count: 1)

    select("Part IV", from: "Part of Register")
    click_on("Apply Filter")
    expect(page).not_to have_css(results_row_css)
  end

  scenario "filtering by part" do
    select("Part III", from: "Part of Register")
    click_on("Apply Filter")
    expect(page).to have_css(results_row_css, count: 1)

    select("Part IV", from: "Part of Register")
    click_on("Apply Filter")
    expect(page).not_to have_css(results_row_css)
  end

  scenario "filtering by fee_receipt_date" do
    find("#filter_date_start").set("21/01/2017")
    find("#filter_date_end").set("22/01/2017")
    click_on("Apply Filter")
    expect(page).to have_css(results_row_css, count: 1)

    find("#filter_date_start").set("21/01/2016")
    find("#filter_date_end").set("22/01/2016")
    click_on("Apply Filter")
    expect(page).not_to have_css(results_row_css)
  end
end

def results_row_css
  "tr.finance-payment"
end
