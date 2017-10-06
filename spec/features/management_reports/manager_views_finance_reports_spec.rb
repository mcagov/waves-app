require "rails_helper"

describe "User views Finance reports", js: true do
  before do
    @check_refund =
      create(
        :submitted_finance_payment,
        payment_date: "22/12/2016",
        application_ref_no: "to-be-ignored",
        payment_amount: -25,
        payment_type: "cheque",
        part: :part_1)

    @cash_income =
      create(
        :submitted_finance_payment,
        payment_date: "23/12/2016",
        application_ref_no: "to-be-ignored",
        payer_name: "BOB",
        payment_amount: 50,
        payment_type: "cash",
        part: :part_2)

    @check_refund.submission.update_attribute(:ref_no, "CHK_REFUND")
    @cash_income.submission.update_attribute(:ref_no, "CASH_INCOME")

    login_to_reports
    visit admin_report_path(:finance_income)

    click_on("Income Reports")
  end

  scenario "Income Report" do
    expect_link_to_export_or_print(true)

    select("Income Report", from: "Report")
    find("#filter_date_start").set("01/12/2016")
    find("#filter_date_end").set("31/12/2016")
    click_on("Apply Filter")

    within(find_all("#results tr")[1]) do
      cells = find_all("td")

      within(cells[0]) { expect(page).to have_text("23/12/2016") }
      within(cells[2]) { expect(page).to have_text("CASH_INCOME") }
      within(cells[3]) { expect(page).to have_text("50.00") }
      within(cells[4]) { expect(page).to have_text("BOB") }
      within(cells[5]) { expect(page).to have_text("CASH") }
      within(cells[6]) { expect(page).to have_text("Part II") }
    end

    expect(find_all("#results tr").length).to eq(2)
  end

  scenario "Refunds Report" do
    select("Refunds Report", from: "Report")
    find("#filter_date_start").set("01/12/2016")
    find("#filter_date_end").set("31/12/2016")
    click_on("Apply Filter")

    within(find_all("#results tr")[1]) do
      cells = find_all("td")

      within(cells[0]) { expect(page).to have_text("22/12/2016") }
      within(cells[3]) { expect(page).to have_text("-25.00") }
      within(cells[5]) { expect(page).to have_text("CHQ") }
      within(cells[6]) { expect(page).to have_text("Part I") }

      within(cells[2]) do
        target = submission_path(@check_refund.submission.id)
        expect(page).to have_link("CHK_REFUND", href: target)
      end
    end

    expect(find_all("#results tr").length).to eq(2)
  end
end
