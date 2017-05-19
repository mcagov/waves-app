require "rails_helper"

describe Decorators::Vessel, type: :model do
  context "#vessel_type_description" do
    let(:vessel) do
      build(:registered_vessel, vessel_category: "MY CATEGORY",
                                vessel_type: vessel_type)
    end

    subject { described_class.new(vessel).vessel_type_description }

    context "when the vessel_type is blank" do
      let(:vessel_type) { "" }

      it { expect(subject).to eq("MY CATEGORY") }
    end

    context "when the vessel_type is present" do
      let(:vessel_type) { "MY TYPE" }

      it { expect(subject).to eq("MY TYPE") }
    end
  end
end
