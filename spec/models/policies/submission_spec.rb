require "rails_helper"

describe Policies::Submission do
  context "#registered_vessel_required?" do
    let(:submission) { build(:submission) }

    subject { Policies::Submission.registered_vessel_required?(submission) }

    context "when the task is :new_registration or :unknown" do
      before { submission.task = [:new_registration, :unknown].sample }

      it { expect(subject).to be_falsey }
    end

    context "when the task is :foo (i.e. any other task)" do
      before { submission.task = :foo }

      it { expect(subject).to be_truthy }
    end
  end

  context "#editable?" do
    before do
      allow(submission).to receive(:completed?).and_return(completed)
    end

    let(:completed) { false }
    let(:submission) { build(:submission) }

    subject { submission.editable? }

    it { expect(subject).to be_truthy }

    context "when the current_state is completed" do
      let(:completed) { true }

      it { expect(subject).to be_falsey }
    end

    context "when officer_intervention_required" do
      before { submission.officer_intervention_required = true }

      it { expect(subject).to be_falsey }
    end
  end

  context "#actionable?" do
    before do
      expect(Policies::Submission)
        .to receive(:approvable?)
    end

    it { build(:submission).approvable? }
  end

  describe "approvable?" do
    let!(:submission) { create(:incomplete_submission) }
    subject { submission.approvable? }

    context "with outstanding declarations" do
      it { expect(subject).to be_falsey }

      context "with completed declarations but awaiting_payment" do
        before do
          submission.declarations.incomplete.map(&:declared!)

          account_ledger_instance =
            double(:account_ledger, awaiting_payment?: awaiting_payment)

          allow(AccountLedger)
            .to receive(:new).with(submission)
            .and_return(account_ledger_instance)
        end

        let(:awaiting_payment) { true }

        it { expect(subject).to be_falsey }

        context "with completed declarations and not awaiting_payment" do
          let(:awaiting_payment) { false }

          it { expect(subject).to be_truthy }
        end
      end
    end
  end
end
