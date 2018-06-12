require "rails_helper"

describe SequenceNumber::Generator do
  context ".reg_no!" do
    subject { described_class.reg_no!(part) }

    context "part_1" do
      let(:part) { :part_1 }

      it { expect(subject).to match(/93[0-9]{4}/) }
    end

    context "part_2" do
      let(:part) { :part_2 }

      it { expect(subject).to match(/C3[0-9]{4}/) }
    end

    context "part_3" do
      let(:part) { :part_3 }

      it { expect(subject).to match(/SSR2[0-9]{5}/) }
    end

    context "part_4" do
      let(:part) { :part_4 }

      it { expect(subject).to match(/X[0-9]{5}/) }
    end
  end

  context ".port_no!" do
    before do
      @su_one = described_class.port_no!("SU")
      @su_two = described_class.port_no!("SU")
      @py_one = described_class.port_no!("PY")
    end

    it "creates sequential numbers within the same port" do
      expect(@su_one).to eq(1)
      expect(@su_two).to eq(2)
    end

    it "creates a unique sequence number for a different port" do
      expect(@py_one).to eq(1)
    end
  end
end
