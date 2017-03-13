require "rails_helper"

describe Decorators::Vessel, type: :model do
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
