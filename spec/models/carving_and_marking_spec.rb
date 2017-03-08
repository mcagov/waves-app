require "rails_helper"

RSpec.describe CarvingAndMarking, type: :model do
  describe "tonnage details" do
    let(:changeset) do
      { vessel_info: { register_tonnage: register, net_tonnage: net } }
    end
    let(:submission) { build(:submission, changeset: changeset) }

    subject { build(:carving_and_marking, submission: submission) }

    context "with no tonnage defined" do
      let(:net) { "" }
      let(:register) { 0 }

      it { expect(subject.tonnage_label).to eq("NET TONNAGE") }
      it { expect(subject.tonnage_value).to eq(0.00) }
      it { expect(subject.tonnage_description).to eq("N.T.0.00") }
    end

    context "with net_tonnage and register_tonnage defined" do
      let(:net) { 12345.67 }
      let(:register) { 45678.9 }

      it { expect(subject.tonnage_label).to eq("NET TONNAGE") }
      it { expect(subject.tonnage_value).to eq(12345.67) }
      it { expect(subject.tonnage_description).to eq("N.T.12,345.67") }
    end

    context "with only register_tonnage defined" do
      let(:net) { "" }
      let(:register) { 45678.9 }

      it { expect(subject.tonnage_label).to eq("REGISTER TONNAGE") }
      it { expect(subject.tonnage_value).to eq(45678.90) }
      it { expect(subject.tonnage_description).to eq("R.T.45,678.90") }
    end
  end
end
