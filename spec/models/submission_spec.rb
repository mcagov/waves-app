require "rails_helper"

describe Submission, type: :model do
  context "in general" do
    let!(:submission) { create_incomplete_submission! }

    it "gets the vessel_info" do
      expect(submission.vessel).to be_a(Submission::Vessel)
    end

    it "get two declarations" do
      expect(submission.declarations.length).to eql(2)
    end

    it "has a state: incomplete" do
      expect(submission).to be_incomplete
    end

    it "has a ref_no" do
      expect(submission.ref_no).to be_present
    end

    it "has some declarations" do
      expect(submission.declarations).not_to be_empty
    end

    it "gets the delivery_address" do
      expect(submission.delivery_address.country).to eq("UNITED KINGDOM")
    end
  end

  context "declarations" do
    let!(:submission) { create_incomplete_submission! }

    it "has one completed declaration" do
      expect(submission.declarations.completed.length).to eq(1)
    end

    it "has one incomplete declaration" do
      expect(submission.declarations.incomplete.length).to eq(1)
    end

    it "does not build a notification for the completed declaration" do
      expect(submission.declarations.completed.first.notification).to be_nil
    end

    it "builds a notification for the incomplete declaration" do
      expect(submission.declarations.incomplete.first.notification)
        .to be_a(Notification::OutstandingDeclaration)
    end
  end

  context "#approved!" do
    let!(:submission) { create_assigned_submission! }
    before do
      expect(submission).to receive(:process_application)
      submission.approved!
    end

    it "transitions to printing" do
      expect(submission.reload).to be_printing
    end
  end

  context "#unreferred!" do
    let!(:submission) { create_referred_submission! }
    before do
      expect(submission).to receive(:init_processing_dates).once
      submission.unreferred!
    end

    it "transitions to unassigned" do
      expect(submission).to be_unassigned
    end

    it "unsets referred_until" do
      expect(submission.referred_until).to be_blank
    end
  end

  context "paid! (with a declared submission)" do
    context "with standard service" do
      let!(:submission) { create_assigned_submission! }

      it "sets the received_at date to today" do
        expect(submission.received_at.to_date)
          .to eq(Date.today)
      end

      it "sets the target_date to 20 days away" do
        expect(submission.target_date.to_date)
          .to eq(Date.today.advance(days: 20))
      end

      it "is not urgent" do
        expect(submission.is_urgent).to be_falsey
      end
    end

    context "with urgent service" do
      let!(:submission) { create_unassigned_urgent_submission! }

      it "sets the target_date to 5 days away (best guess)" do
        expect(submission.target_date.to_date)
          .to eq(Date.today.advance(days: 5))
      end

      it "is urgent" do
        expect(submission.is_urgent).to be_truthy
      end
    end
  end

  context "paid! (with an undeclared submission)" do
    let!(:submission) { create_incomplete_submission! }

    it "does not set the received_at date" do
      expect(submission.received_at).to be_blank
    end

    it "does not set the target_date" do
      expect(submission.target_date).to be_blank
    end
  end

  context ".referred_until_expired" do
    let!(:submission) { create(:submission, referred_until: referred_until) }
    let(:submissions) { Submission.referred_until_expired }

    context "tomorrow" do
      let(:referred_until) { Date.tomorrow }
      it { expect(submissions).to be_empty }
    end

    context "today" do
      let(:referred_until) { Date.today }
      it { expect(submissions.length).to eq(1) }
    end

    context "yesterday" do
      let(:referred_until) { Date.yesterday }
      it { expect(submissions.length).to eq(1) }
    end

    context "nil" do
      let(:referred_until) { nil }
      it { expect(submissions).to be_empty }
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

    it "builds a list" do
      expect(submission.notification_list).to eq(
        [outstanding_declaration,
         recent_notification, correspondence, old_notification]
      )
    end
  end

  context "#editable?" do
    let(:submission) { Submission.new(state: submission_state) }
    subject { submission.editable? }

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
end
