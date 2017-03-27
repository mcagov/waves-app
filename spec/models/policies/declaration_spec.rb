require "rails_helper"

describe Policies::Declarations do
  let(:policy) { described_class.new(submission) }

  describe ".declaration_status" do
    subject { policy.declaration_status }

    context "for a part_3 submission" do
      context "when there are no declarations" do
        let(:submission) { build(:incomplete_submission) }

        it { expect(subject).to eq("Undefined") }
      end

      context "when there is an incomplete declaration" do
        let(:submission) do
          create(:incomplete_submission, declarations: [build(:declaration)])
        end

        it { expect(subject).to eq("Incomplete") }
      end

      context "when there is a completed declaration" do
        let(:submission) { create(:assigned_submission) }

        it { expect(subject).to eq("Complete") }
      end
    end

    context "for a part_4 submission" do
      context "when there are no charter_parties" do
        let(:submission) { build(:incomplete_submission, part: :part_4) }

        it { expect(subject).to eq("Undefined") }
      end

      context "when there is an incomplete declaration" do
        let(:submission) do
          create(
            :incomplete_submission,
            part: :part_4,
            charterers: [build(:charterer)])
        end

        it { expect(subject).to eq("Incomplete") }
      end

      context "when there is a completed declaration" do
        let(:submission) do
          create(
            :submission,
            part: :part_4,
            charterers: [build(:declared_charterer)])
        end

        it { expect(subject).to eq("Complete") }
      end
    end
  end
end
