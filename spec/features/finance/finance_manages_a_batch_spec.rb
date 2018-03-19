require "rails_helper"

describe "Finance manages a batch", type: :feature do
  context "in general" do
    before do
      login_to_finance
      visit finance_batch_payments_path(batch)
    end

    context "with a payment" do
      let(:batch) { create(:finance_batch) }

      scenario "ending and re-opening a batch" do
        expect(page).not_to have_link(cancel_batch_text)

        click_on("End Batch")
        click_on(re_open_batch_link_text)
        expect(page).to have_link(new_fee_entry_link_text)

        click_on(end_batch_link_text)
        expect(page).to have_link(re_open_batch_link_text)
        expect(page).not_to have_link(new_fee_entry_link_text)
      end

      scenario "ending and locking a batch" do
        click_on("End Batch")
        click_on("Lock Batch")

        expect(page).to have_current_path(finance_batch_payments_path(batch))
        expect(page).not_to have_link(re_open_batch_link_text)
        expect(page).not_to have_link(end_batch_link_text)
        expect(page).not_to have_link(new_fee_entry_link_text)

        expect(FinanceBatch.last).to be_locked
      end
    end

    context "with no payments" do
      let(:batch) { create(:empty_finance_batch) }

      scenario "deleting an empty batch" do
        click_on(cancel_batch_text)

        expect { FinanceBatch.find(batch) }.to raise_error
      end
    end
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

def cancel_batch_text
  "Cancel Batch"
end
