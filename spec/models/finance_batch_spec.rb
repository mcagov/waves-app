require "rails_helper"

describe FinanceBatch do
  let!(:batch) { create(:finance_batch) }

  context ".toggle_state!" do
    it "is not closed" do
      expect(batch).not_to be_closed
    end

    context "ending a batch" do
      before { batch.toggle_state! }
      it { expect(batch).to be_closed }

      context "reopening a closed batch" do
        before { batch.toggle_state! }
        it { expect(batch).not_to be_closed }
      end
    end
  end

  context ".total_amount" do
    before do
      expect(batch)
        .to receive(:payments).and_return(
          [create(:payment, amount: 2020), create(:payment, amount: 1111)]
        )
    end

    it { expect(batch.total_amount).to eq(3131) }
  end
end
