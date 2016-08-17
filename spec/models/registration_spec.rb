require "rails_helper"

describe Registration, type: :model do

  context "in general" do
    let!(:registration) { create_registration! }

    it "gets the vessel_info" do
      expect(registration.vessel_info).to eq(registration.submission[:vessel_info])
    end

    it "get two owners" do
      expect(registration.owners.length).to eql(2)
    end
  end

  context "#paid?" do
    context "has a status: :paid" do
      subject { build(:paid_registration).paid? }
      it { expect(subject).to be_truthy }
    end

    context "has a status: :foo" do
      subject { build(:registration).paid? }
      it { expect(subject).to be_falsey }
    end
  end

  context "declared_by?" do
    let!(:registration) { create_registration! }

    it "was declared_by by the first owner" do
      expect(registration).to be_declared_by(registration.owners.first)
    end

    it "was not declared_by by the second owner" do
      expect(registration).not_to be_declared_by(registration.owners.last)
    end
  end

  context "#vessel_type" do
    let(:registration)  do
      build(:registration, changeset: { vessel_info: vessel_info })
    end

    subject { registration.vessel_type }

    context "with the vessel_type field" do
      let(:vessel_info) { {vessel_type: "Barge"} }
      it { expect(subject).to eq("Barge") }
    end

    context "using vessel_type_other field" do
      let(:vessel_info) { {vessel_type: "", vessel_type_other: "Zebra"} }
      it { expect(subject).to eq("Zebra") }
    end

  end
end
