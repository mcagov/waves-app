require "rails_helper"

describe Registration, type: :model do

  context "in general" do
    let!(:registration) { create_registration! }

    it "gets the correspondent" do
      expect(registration.correspondent).to eq(registration.submission[:owners][0])
    end

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
end
