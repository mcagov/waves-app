require "rails_helper"

describe Policies::Declarations do
  let(:policy) { described_class.new(submission) }

  describe ".declaration_status" do
    subject { policy.declaration_status }

    context "for a part_3 vessel" do
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
  end
end
