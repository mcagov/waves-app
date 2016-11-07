require "rails_helper"

describe AccountLedger do
  let(:account_ledger) { described_class.new(submission) }
  context "#payment_status" do
    subject { account_ledger.payment_status }

    context "with full payment" do
      let(:submission) { create(:paid_submission) }

      it { expect(subject).to eq(:paid) }
    end

    context "with full payment for urgent service" do
      let(:submission) { create(:paid_urgent_submission) }

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

  context "#service_level" do
    subject { account_ledger.service_level }

    context "with full payment" do
      let(:submission) { create(:paid_submission) }

      it { expect(subject).to eq(:standard) }
    end

    context "with full payment for urgent service" do
      let(:submission) { create(:paid_urgent_submission) }

      it { expect(subject).to eq(:urgent) }
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
