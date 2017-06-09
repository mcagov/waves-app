require "rails_helper"

describe Report do
  describe "RenderAsRegistrationStatus" do
    subject { Report::RenderAsRegistrationStatus.new(:registered) }

    it "supports to_s" do
      expect(subject.to_s).to eq(:registered)
    end
  end

  describe "RenderAsLinkToVessel" do
    let(:vessel) { build(:registered_vessel) }
    subject { Report::RenderAsLinkToVessel.new(vessel) }

    it "supports to_s" do
      expect(subject.to_s).to eq(vessel.to_s)
    end
  end
end
