require "rails_helper"

describe Submission, type: :model do

  context "in general" do
    let!(:submission) { create_submission! }

    it "gets the vessel_info" do
      expect(submission.vessel).to be_a(Submission::Vessel)
    end

    it "get two owners" do
      expect(submission.owners.length).to eql(2)
    end

    it "has a state: incomplete" do
      expect(submission).to be_incomplete
    end

    context "#paid?" do
      subject { build(:paid_submission).paid? }
      it { expect(subject).to be_truthy }
    end

    context "not paid" do
      subject { build(:submission).paid? }
      it { expect(subject).to be_falsey }
    end

    context "declared_by?" do
      let!(:submission) { create_submission! }

      it "was declared_by by the first owner" do
        expect(submission).to be_declared_by(submission.owners.first.email)
      end

      it "was not declared_by by the second owner" do
        expect(submission).not_to be_declared_by(submission.owners.last.email)
      end
    end
  end

  context "#approved!" do
    let!(:submission) { create_completeable_submission! }
    before { submission.approved! }

    it "transitions to completed" do
      expect(submission.reload).to be_completed
    end
  end
end
