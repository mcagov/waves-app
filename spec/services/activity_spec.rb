require "rails_helper"

describe Activity do
  describe "#registration_officer?" do
    subject { described_class.new(part).registration_officer? }

    context "with a reg officer" do
      let(:part) { :part_3 }

      it { expect(subject).to be_truthy }
    end

    context "with a finance person" do
      let(:part) { :finance }

      it { expect(subject).to be_falsey }
    end

    context "with a reports person" do
      let(:part) { :reports }

      it { expect(subject).to be_falsey }
    end
  end
end
