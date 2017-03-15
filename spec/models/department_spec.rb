require "rails_helper"

describe Department do
  let(:department) { described_class.new(part, registration_type) }

  context "#code" do
    subject { department.code }

    context "bareboat" do
      let(:part) { :part_4 }
      let(:registration_type) { :foo }

      it { expect(subject).to eq(:bareboat) }
    end

    context "commercial" do
      let(:part) { :part_1 }
      let(:registration_type) { :commercial }

      it { expect(subject).to eq(:commercial) }
    end

    context "fishing" do
      let(:part) { :part_2 }
      let(:registration_type) { "" }

      it { expect(subject).to eq(:fishing) }
    end

    context "pleasure" do
      let(:part) { :part_1 }
      let(:registration_type) { :pleasure }

      it { expect(subject).to eq(:pleasure) }
    end

    context "ssr" do
      let(:part) { :part_3 }
      let(:registration_type) { nil }

      it { expect(subject).to eq(:ssr) }
    end
  end
end
