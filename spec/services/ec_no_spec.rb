require "rails_helper"

describe EcNo do
  context ".for_submission" do
    subject { described_class.for_submission(submission) }

    context "is blank by default" do
      let(:submission) { build(:submission) }

      it { expect(subject).to be_blank }
    end

    context "with a pleasure vessel" do
      let(:submission) { create(:pleasure_submission) }
      let(:vessel) { submission.registered_vessel }

      it { expect(subject).to be_blank }
    end

    context "with a fishing vessel" do
      let(:submission) { create(:fishing_submission) }
      let(:vessel) { submission.registered_vessel }

      it "is formatted" do
        expect(subject).to eq("GBR000#{vessel.reg_no}")
      end
    end
  end

  context ".for_vessel" do
    subject { described_class.for_vessel(vessel) }

    context "with a pleasure vessel" do
      let(:vessel) { create(:pleasure_vessel) }

      it { expect(subject).to be_blank }
    end

    context "with a fishing vessel" do
      let(:vessel) { create(:fishing_vessel) }

      it "is formatted" do
        expect(subject).to eq("GBR000#{vessel.reg_no}")
      end
    end
  end
end
