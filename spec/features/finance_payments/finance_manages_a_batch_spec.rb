require "rails_helper"

describe "Finance manages a batch", type: :feature do
  before do
    @batch = create(:finance_batch)
    finance_payment = create(:finance_payment, batch: @batch)

    login_to_finance
    visit finance_batch_payment_path(@batch, finance_payment)

    click_on("End Batch")
  end

  scenario "re-opening a batch" do
    expect(page).to have_current_path(finance_batch_payments_path(@batch))
    expect(page).to have_text("End Date: ")

    click_on(re_open_batch_link_text)

    expect(page).to have_current_path(finance_batch_payments_path(@batch))
    expect(page).not_to have_text("End Date: ")
    expect(page).to have_link("New Fee Entry")
  end

  scenario "locking a batch" do
    expect(page).to have_link(re_open_batch_link_text)
    click_on("Lock Batch")

    expect(page).to have_current_path(finance_batch_payments_path(@batch))
    expect(page).not_to have_link(re_open_batch_link_text)
    expect(FinanceBatch.last).to be_locked
  end
end

def re_open_batch_link_text
  "Re-Open Batch"
end
