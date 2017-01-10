require "rails_helper"

describe SequenceNumber::Generator do
  context ".reg_no!" do
    let(:registered_vessel) { build(:registered_vessel, part: part) }
    subject { described_class.reg_no!(registered_vessel) }

    context "part_1" do
      let(:part) { :part_1 }

      it { expect(subject).to match(/6[0-9]{5}/) }
    end

    context "part_2" do
      let(:part) { :part_2 }

      it { expect(subject).to match(/C[0-9]{5}/) }
    end

    context "part_3" do
      let(:part) { :part_3 }

      it { expect(subject).to match(/SSR2[0-9]{5}/) }
    end

    context "part_4" do
      let(:part) { :part_4 }

      it { expect(subject).to match(/8[0-9]{5}/) }
    end
  end
end
