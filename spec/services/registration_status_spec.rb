require "rails_helper"

describe RegistrationStatus do
  context "#to_s" do
    subject { described_class.new(vessel).to_s }

    context "with a provisional registration" do
      let(:vessel) { create(:provisionally_registered_vessel) }

      it { expect(subject).to eq("Registered Provisionally") }
    end

    context "with a normal registration" do
      let(:vessel) { create(:registered_vessel) }

      it { expect(subject).to eq("Registered") }
    end
  end
end
