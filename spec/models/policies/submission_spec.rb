require "rails_helper"

describe Policies::Submission do
  context "#actionable?" do
    before do
      expect(Policies::Submission)
        .to receive(:approvable?)
    end

    it { build(:submission).approvable? }
  end

  context "#printing_completed?" do
    subject { submission.printing_completed? }

    context "with outstanding print jobs" do
      let!(:submission) { create_printing_submission! }

      it { expect(subject).to be_falsey }
    end

    context "with no outstanding print jobs" do
      let!(:submission) { create_completed_submission! }

      it { expect(subject).to be_truthy }
    end
  end

  describe "approvable?" do
    let!(:submission) { create_incomplete_submission! }
    subject { submission.approvable? }

    context "with outstanding declarations" do
      it { expect(subject).to be_falsey }

      context "with completed declarations and no payment" do
        before { submission.declarations.incomplete.map(&:declared!) }

        it { expect(subject).to be_falsey }

        context "with completed declarations and payment" do
          before do
            allow(AccountLedger)
              .to receive(:paid?).with(submission).and_return(true)
          end

          it { expect(subject).to be_truthy }
        end
      end
    end
  end
end
