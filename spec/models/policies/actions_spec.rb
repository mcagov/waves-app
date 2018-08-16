require "rails_helper"

describe Policies::Actions do
  context "#readonly?" do
    let!(:user) { create(:user) }

    subject { described_class.readonly?(task, user) }

    context "when there is no task" do
      let(:task) { nil }

      it { expect(subject).to be_truthy }
    end

    context "with a task" do
      let(:task) { create(:task, submission: submission) }

      context "when the submission is open" do
        let(:submission) { create(:submission) }

        it { expect(subject).to be_truthy }

        context "and the task is claimed by the user" do
          let(:task) { create(:claimed_task) }

          before do
            expect(task).to receive(:claimed_by?).with(user).and_return(true)
          end

          it { expect(subject).to be_falsey }
        end
      end

      context "when the submission is closed" do
        let(:submission) { create(:closed_submission) }

        it { expect(subject).to be_truthy }
      end
    end
  end

  context "#editable?" do
    let(:task) { create(:claimed_task, service: service) }

    subject { described_class.editable?(task, task.claimant) }

    context "with a task that is registry_not_editable" do
      let(:service) { create(:demo_service, :registry_not_editable) }

      it { expect(subject).to be_falsey }
    end

    context "with a task that is editable" do
      let(:service) { create(:demo_service) }

      it { expect(subject).to be_truthy }

      context "but the application is readonly" do
        before do
          allow(Policies::Actions).to receive(:readonly?).and_return(true)
        end

        it { expect(subject).to be_falsey }
      end
    end
  end

  context "#registered_vessel_required?" do
    let(:submission) { build(:submission) }

    subject { Policies::Actions.registered_vessel_required?(submission) }

    context "when the task is :new_registration or :unknown" do
      before { submission.task = [:new_registration, :unknown].sample }

      it { expect(subject).to be_falsey }
    end

    context "when the task is :provisional" do
      before { submission.task = :provisional }

      it { expect(subject).to be_falsey }
    end

    context "when the task is :foo (i.e. any other task)" do
      before { submission.task = :foo }

      it { expect(subject).to be_truthy }
    end
  end
end
