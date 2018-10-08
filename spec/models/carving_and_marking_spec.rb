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
      it { expect(subject.tonnage_value).to eq("") }
      it { expect(subject.tonnage_description).to eq("") }
    end

    context "with net_tonnage and register_tonnage defined" do
      let(:net) { 12345.67 }
      let(:register) { 45678.9 }

      it { expect(subject.tonnage_label).to eq("NET TONNAGE") }
      it { expect(subject.tonnage_value).to eq("12,345.67") }
      it { expect(subject.tonnage_description).to eq("N.T.12,345.67") }
    end

    context "with only register_tonnage defined" do
      let(:net) { "" }
      let(:register) { 45678.9 }

      it { expect(subject.tonnage_label).to eq("REGISTER TONNAGE") }
      it { expect(subject.tonnage_value).to eq("45,679") }
      it { expect(subject.tonnage_description).to eq("R.T.45,679") }
    end
  end

  describe "template_name" do
    let(:carving_and_marking) { described_class.new(template: template) }
    subject { carving_and_marking.template_name }

    context "under_24m" do
      let(:template) { "under_24m" }

      it { expect(subject).to eq("Part 1 pleasure vessels under 24m") }
    end
  end

  describe "emailable?" do
    let(:carving_and_marking) do
      build(:carving_and_marking, delivery_method: delivery_method)
    end

    subject { carving_and_marking.emailable? }

    context "email" do
      let(:delivery_method) { :email }

      it { expect(subject).to be_truthy }
    end

    context "print" do
      let(:delivery_method) { :print }

      it { expect(subject).to be_falsey }
    end
  end
end
