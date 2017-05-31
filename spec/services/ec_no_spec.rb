require "rails_helper"

describe EcNo do
  context ".for_vessel" do
    subject { described_class.for_vessel(vessel) }

    context "is blank by default" do
      let(:vessel) { build(:registered_vessel) }

      it { expect(subject).to be_blank }
    end

    context "with a pleasure vessel" do
      let(:vessel) { create(:pleasure_vessel) }

      it { expect(subject).to be_blank }
    end

    context "with a fishing vessel" do
      let(:vessel) { create(:fishing_vessel) }

      it "is formatted" do
        expect(subject).to eq("GBR000#{vessel.reg_no}")
      end
    end

    context "when the vessel has an ec_no defined" do
      let(:vessel) { create(:fishing_vessel, ec_no: "BOB") }

      it "retrieves that number" do
        expect(subject).to eq("BOB")
      end
    end
  end
end
