require "rails_helper"

describe FinanceBatch do
  context ".toggle_state!" do
    let(:batch) { create(:finance_batch) }

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
end
