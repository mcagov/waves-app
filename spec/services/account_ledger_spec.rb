require "rails_helper"

describe AccountLedger do
  context ".paid?" do
    subject { AccountLedger.paid?(submission) }

    context "with a payment" do
      let(:submission) { create(:paid_submission) }

      it { expect(subject).to be_truthy }
    end

    context "with no payment" do
      let(:submission) { create(:submission) }

      it { expect(subject).to be_falsey }
    end
  end
end
