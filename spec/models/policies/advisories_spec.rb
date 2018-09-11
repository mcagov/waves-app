require "rails_helper"

describe Policies::Advisories do
  context ".for_submission" do
    subject { described_class.for_submission(submission) }

    context "part_2 (fishing) vessel" do
      let(:submission) { build(:submission, :part_2_vessel) }

      it { expect(subject).to include(:fishing_vessel_safety_certificate) }

      context "with a fishing_vessel_safety_certificate" do
        before do
          create(
            :document,
            entity_type: :fishing_vessel_safety_certificate,
            expires_at: expires_at,
            noteable: submission)
        end

        context "that is valid" do
          let(:expires_at) { 1.month.from_now }

          it { expect(subject).to be_empty }
        end

        context "that has expired" do
          let(:expires_at) { 1.month.ago }

          it do
            expect(subject).to include(:fishing_vessel_safety_certificate)
          end
        end
      end
    end

    context "part_1 (not a fishing) vessel" do
      let(:submission) { build(:submission, :part_1_vessel) }

      it { expect(subject).to be_empty }
    end
  end
end
