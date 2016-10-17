require "rails_helper"

describe Decorators::Submission, type: :model do
  context "#editable?" do
    let(:submission) { Submission.new(state: submission_state) }
    subject { described_class.new(submission).editable? }

    context "when the state is completed" do
      let(:submission_state) { :completed }

      it { expect(subject).to be_falsey }
    end

    context "when the state is printing" do
      let(:submission_state) { :printing }

      it { expect(subject).to be_falsey }
    end

    context "when the state is something else" do
      let(:submission_state) { "" }

      it { expect(subject).to be_truthy }
    end
  end

  context "#notification_list" do
    let!(:submission) { build(:submission) }

    before do
      expect(Builders::NotificationListBuilder)
        .to receive(:for_submission)
        .with(submission)
    end

    it { described_class.new(submission).notification_list }
  end
end
