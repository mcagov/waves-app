require "rails_helper"

describe Policies::Definitions do
  context ".mortgageable?" do
    subject { described_class.mortgageable?(vessel) }

    context "by default" do
      let(:vessel) do
        build(:registered_vessel, part: :part_2, registration_type: :simple)
      end

      it { expect(subject).to be_falsey }
    end

    context "for a :part_1 vessel" do
      let(:vessel) { build(:registered_vessel, part: :part_1) }

      it { expect(subject).to be_truthy }
    end

    context "for a :part_2, :full vessel" do
      let(:vessel) do
        build(:registered_vessel, part: :part_2, registration_type: "full")
      end

      it { expect(subject).to be_truthy }
    end
  end
end
