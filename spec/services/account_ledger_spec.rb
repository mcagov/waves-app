require "rails_helper"

describe AccountLedger do
  let(:account_ledger) { described_class.new(submission) }

  context "#payment_status" do
    subject { account_ledger.payment_status }

    context "not_applicable" do
      let(:submission) { build(:submission, task: :closure) }

      it { expect(subject).to eq(:not_applicable) }
    end

    context "unpaid" do
      let(:submission) { build(:submission) }

      it { expect(subject).to eq(:unpaid) }
    end

    context "paid" do
      let(:submission) do
        submission = create(:line_item, price: 2500).submission
        create(:payment, submission: submission, amount: 2500)
        submission.reload
      end
      it { expect(subject).to eq(:paid) }
    end

    context "part_paid" do
      let(:submission) do
        submission = create(:line_item, price: 2500).submission
        create(:payment, submission: submission, amount: 1500)
        submission.reload
      end

      it { expect(subject).to eq(:part_paid) }
    end
  end

  context "#awaiting_payment?" do
    let(:submission) { build(:submission) }

    before do
      allow(account_ledger)
        .to receive(:payment_status)
        .and_return(payment_status)
    end

    subject { account_ledger.awaiting_payment? }

    context "not_applicable" do
      let(:payment_status) { :not_applicable }

      it { expect(subject).to be_falsey }
    end

    context "paid" do
      let(:payment_status) { :paid }

      it { expect(subject).to be_falsey }
    end

    context "unpaid" do
      let(:payment_status) { :unpaid }

      it { expect(subject).to be_truthy }
    end

    context "part_paid" do
      let(:payment_status) { :part_paid }

      it { expect(subject).to be_truthy }
    end
  end

  context "#amount_due" do
    subject { account_ledger.amount_due }

    context "by default (no line_items)" do
      let!(:submission) { create(:submission) }

      it { expect(subject).to eq(0.00) }
    end

    context "with a line item" do
      let!(:submission) { create(:line_item).submission }

      it { expect(subject).to eq(2500) }
    end
  end
end
