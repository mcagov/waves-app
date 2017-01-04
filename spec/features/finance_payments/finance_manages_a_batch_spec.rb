require "rails_helper"

describe "Finance manages a batch", type: :feature do
  before do
    @batch = create(:finance_batch)
    finance_payment = create(:finance_payment, batch: @batch)

    login_to_finance
    visit finance_batch_payment_path(@batch, finance_payment)
  end

  scenario "ending and re-opening a batch" do
    click_on("End Batch")

    expect(page).to have_current_path(finance_batch_payments_path(@batch))
    expect(page).to have_text("End Date: ")

    click_on("Re-Open Batch")

    expect(page).to have_current_path(finance_batch_payments_path(@batch))
    expect(page).not_to have_text("End Date: ")
    expect(page).to have_link("New Fee Entry")
  end
end
