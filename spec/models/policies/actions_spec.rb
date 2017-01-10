require "rails_helper"

describe Policies::Actions do
  context "#registered_vessel_required?" do
    let(:submission) { build(:submission) }

    subject { Policies::Actions.registered_vessel_required?(submission) }

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
    let(:submission) do
      build(:submission, source: source, state: current_state)
    end

    let(:source) { :online }
    let(:current_state) { :assigned }

    subject { submission.actionable? }

    context "when the source is :online" do
      before do
        allow(Policies::Actions)
          .to receive(:approvable?).with(submission)
          .and_return(true)
      end

      it { expect(subject).to be_truthy }

      context "and the current_state is :completed" do
        let(:current_state) { :completed }

        it { expect(subject).to be_falsey }
      end
    end

    context "when the source is :manual_entry" do
      let(:source) { :manual_entry }

      it { expect(subject).to be_truthy }

      context "and the current_state is :completed" do
        let(:current_state) { :completed }

        it { expect(subject).to be_falsey }
      end
    end
  end

  describe "approvable?" do
    subject { submission.approvable? }

    context "manual_override" do
      let(:submission) { build(:submission, task: :manual_override) }

      it { expect(subject).to be_truthy }
    end

    context "frozen /unfrozen" do
      let(:submission) { create(:assigned_submission) }

      context "in general (i.e. not frozen)" do
        it { expect(subject).to be_truthy }
      end

      context "when the registration_status is :frozen" do
        before do
          allow(submission)
            .to receive(:registration_status).and_return(:frozen)
        end

        it { expect(subject).to be_falsey }
      end
    end

    context "with outstanding declarations" do
      let!(:submission) { create(:incomplete_submission) }
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
