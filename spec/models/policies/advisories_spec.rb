require "rails_helper"

describe Policies::Advisories do
  context ".for_submission" do
    subject { described_class.for_submission(submission) }

    context "fishing vessel" do
      let(:submission) { build(:fishing_submission) }

      it { expect(subject).to include(:fishing_vessel_safety_certificate) }
    end

    context "not a fishing vessel" do
      let(:submission) { build(:pleasure_submission) }

      it { expect(subject).to be_empty }
    end
  end
end
