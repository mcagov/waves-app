require "rails_helper"

describe Tonnage do
  describe "#to_s" do
    let(:tonnage) { Tonnage.new(mode, value) }
    let(:mode) { :foo }
    let(:value) { 12.567 }

    subject { tonnage.to_s }

    context "with register tonnage" do
      let(:mode) { :register }

      it { expect(subject).to eq("13") }
    end

    context "with any other tonnage" do
      it { expect(subject).to eq("12.57") }
    end

    context "with an empty value" do
      let(:value) { "" }

      it { expect(subject).to be_empty }
    end
  end
end
