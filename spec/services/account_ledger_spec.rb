require "rails_helper"

describe AccountLedger do
  let(:account_ledger) { described_class.new(submission) }
  context "#payment_status" do
    subject { account_ledger.payment_status }

    context "with full payment" do
      let(:submission) { create(:paid_submission) }

      it { expect(subject).to eq(:paid) }
    end

    context "with full payment for premium service" do
      let(:submission) { create(:paid_premium_submission) }

      it { expect(subject).to eq(:paid) }
    end

    context "with a part payment" do
      let(:submission) { create(:part_paid_submission) }

      it { expect(subject).to eq(:part_paid) }
    end

    context "with no payment" do
      let(:submission) { build(:submission) }

      it { expect(subject).to eq(:unpaid) }
    end

    context "when payment is not required" do
      let(:submission) { build(:submission, task: :closure) }

      it { expect(subject).to eq(:not_applicable) }
    end
  end

  context "#awaiting_payment?" do
    subject { account_ledger.awaiting_payment? }

    context "with no payment" do
      let(:submission) { build(:submission) }

      it { expect(subject).to be_truthy }
    end

    context "with full payment" do
      let(:submission) { create(:paid_submission) }

      it { expect(subject).to be_falsey }
    end

    context "when payment is not required" do
      let(:submission) { build(:submission, task: :closure) }

      it { expect(subject).to be_falsey }
    end
  end
end
