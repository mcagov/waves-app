require "rails_helper"

describe "Finance manages a batch", type: :feature do
  before do
    @batch = create(:finance_batch)

    login_to_finance
    visit finance_batch_payments_path(@batch)

    click_on("End Batch")
  end

  scenario "re-opening a batch" do
    click_on(re_open_batch_link_text)
    expect(page).to have_link(new_fee_entry_link_text)

    click_on(end_batch_link_text)
    expect(page).to have_link(re_open_batch_link_text)
    expect(page).not_to have_link(new_fee_entry_link_text)
  end

  scenario "locking a batch" do
    click_on("Lock Batch")

    expect(page).to have_current_path(finance_batch_payments_path(@batch))
    expect(page).not_to have_link(re_open_batch_link_text)
    expect(page).not_to have_link(end_batch_link_text)
    expect(page).not_to have_link(new_fee_entry_link_text)

    expect(FinanceBatch.last).to be_locked
  end
end

def re_open_batch_link_text
  "Re-Open Batch"
end

def end_batch_link_text
  "End Batch"
end

def new_fee_entry_link_text
  "New Fee Entry"
end
