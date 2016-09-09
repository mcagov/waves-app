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
    before { submission.approved! }

    it "transitions to completed" do
      expect(submission.reload).to be_completed
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
end
