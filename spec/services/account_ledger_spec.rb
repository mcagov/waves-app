require "rails_helper"

describe AccountLedger do
  context ".payment_status" do
    subject { AccountLedger.payment_status(submission) }

    context "with full payment" do
      let(:submission) { create(:paid_submission) }

      it { expect(subject).to eq(:paid) }
    end

    context "with a part payment" do
      let(:submission) { create(:part_paid_submission) }

      it { expect(subject).to eq(:part_paid) }
    end

    context "with no payment" do
      let(:submission) { create(:submission) }

      it { expect(subject).to eq(:unpaid) }
    end
  end
end
