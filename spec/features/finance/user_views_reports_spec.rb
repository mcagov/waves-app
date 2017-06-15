require "rails_helper"

describe "User views Finance reports", js: true do
  before do
    @incomplete_finance_payment =
      create(
        :finance_payment,
        payment_date: "22/12/2016",
        application_ref_no: "SUB1",
        payment_amount: 25,
        payment_type: "cheque",
        part: :part_1)

    @submitted_finance_payment =
      create(
        :submitted_finance_payment,
        payment_date: "23/12/2016",
        application_ref_no: "to-be-ignored",
        payment_amount: 50,
        payment_type: "cash",
        part: :part_2)

    @submitted_finance_payment.submission.update_attribute(:ref_no, "SUB2")

    login_to_finance
    visit admin_report_path(:finance_income)
  end

  scenario "Income" do
    click_on("Income Reports")
    expect_link_to_export_or_print(true)

    find("#filter_date_start").set("01/12/2016")
    find("#filter_date_end").set("31/12/2016")
    click_on("Apply Filter")

    within(find_all("#results tr")[1]) do
      cells = find_all("td")

      within(cells[0]) { expect(page).to have_text("22/12/2016") }
      within(cells[1]) { expect(page).to have_text("SUB1") }
      within(cells[2]) { expect(page).to have_text("25.00") }
      within(cells[3]) { expect(page).to have_text("CHQ") }
      within(cells[4]) { expect(page).to have_text("Part I") }
    end

    within(find_all("#results tr")[2]) do
      cells = find_all("td")

      within(cells[0]) { expect(page).to have_text("23/12/2016") }
      within(cells[1]) { expect(page).to have_text("SUB2") }
      within(cells[2]) { expect(page).to have_text("50.00") }
      within(cells[3]) { expect(page).to have_text("CASH") }
      within(cells[4]) { expect(page).to have_text("Part II") }
    end
  end
end
