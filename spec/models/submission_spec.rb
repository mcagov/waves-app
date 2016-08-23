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

    context "#target_date" do
      let!(:submission) { create_submission! }
      let!(:payment) { create(:payment, submission_id: submission.id, wp_amount: wp_amount)}

      subject { submission.target_date.to_date }

      context "standard service" do
        let(:wp_amount) { 2500 }
        it { expect(subject).to eq(20.days.from_now.to_date) }
      end

      context "premium service" do
        let(:wp_amount) { 7500 }
        it { expect(subject).to eq(5.days.from_now.to_date) }
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
