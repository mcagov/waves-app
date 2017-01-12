require "rails_helper"

describe FinanceBatch do
  let!(:batch) { create(:finance_batch) }

  context ".close!" do
    before { batch.close! }

    it "is closed" do
      expect(batch).to be_closed
    end

    it "sets the closed_at timestamp" do
      expect(batch.closed_at).to be_present
    end

    context ".re_open!" do
      before { batch.re_open! }

      it "is open" do
        expect(batch).to be_open
      end

      it "unsets the closed_at timestamp" do
        expect(batch.closed_at).to be_blank
      end
    end

    context ".lock!" do
      before { batch.lock! }

      it "locks the batch" do
        expect(batch).to be_locked
      end

      it "sets the locked_at timestamp" do
        expect(batch.locked_at).to be_present
      end

      it "locks the finance_payments" do
        expect(batch.finance_payments.first).to be_locked
      end
    end
  end

  context ".total_amount" do
    before do
      expect(batch)
        .to receive(:finance_payments).and_return(
          [
            create(:finance_payment, payment_amount: 2020),
            create(:finance_payment, payment_amount: 1111)]
        )
    end

    it { expect(batch.total_amount).to eq(3131) }
  end

  context ".default_part" do
    it "retrieves the batch's last finance_payment#part" do
      expect(batch.default_part.to_sym).to eq(:part_3)
    end

    it "returns nothing when the batch has no finance_payments" do
      expect(build(:finance_batch).default_part).to be_blank
    end
  end
end
