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

  context "#formatted_propulsion_system" do
    let(:vessel) { build(:registered_vessel, propulsion_system: prop_sys) }

    subject { described_class.new(vessel).formatted_propulsion_system }

    context "when the propulsion_system is not defined" do
      let(:prop_sys) { [] }

      it { expect(subject).to be_blank }
    end

    context "when the propulsion_system is defined" do
      let(:prop_sys) { ["", "steam", "inboard_petrol"] }

      it { expect(subject).to eq("Steam, Internal petrol") }
    end
  end
end
