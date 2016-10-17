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
    let!(:submission) { create(:submission) }

    let!(:outstanding_declaration) do
      create(
        :notification,
        notifiable: create(:declaration, submission: submission),
        created_at: Date.today)
    end

    let!(:old_notification) do
      create(:notification, notifiable: submission, created_at: 1.year.ago)
    end

    let!(:recent_notification) do
      create(:notification, notifiable: submission, created_at: 1.day.ago)
    end

    let!(:correspondence) do
      create(:correspondence, noteable: submission, created_at: 3.days.ago)
    end

    subject { Decorators::Submission.new(submission).notification_list }

    it "builds a list" do
      expect(subject).to eq(
        [outstanding_declaration,
         recent_notification, correspondence, old_notification]
      )
    end
  end
end
