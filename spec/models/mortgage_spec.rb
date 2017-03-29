require "rails_helper"

describe Mortgage do
  context ".types_for(submission)" do
    subject { described_class.types_for(submission) }

    context "when the submission is for a new_registration" do
      let(:submission) { build(:submission) }

      it { expect(subject).to eq(["Intent"]) }
    end

    context "when the submission is for a provisional registration" do
      let(:submission) { build(:submission, task: :provisional) }

      it { expect(subject).to eq(["Intent"]) }
    end

    context "when the submission is not a new_registration" do
      let(:submission) { build(:submission, task: :change_vessel) }

      it do
        expect(subject).to eq(["Intent", "Account Current", "Principle Sum"])
      end
    end
  end
end
