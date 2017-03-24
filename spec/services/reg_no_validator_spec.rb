require "rails_helper"

describe RegNoValidator do
  context "#valid?" do
    subject { described_class.valid?(reg_no) }

    context "validating the existince of a given reg_no" do
      let(:reg_no) { "MY_REG_NO" }

      context "when the reg_no exists" do
        before do
          create(:registered_vessel).update_attributes(reg_no: "MY_REG_NO")
        end

        it { expect(subject).to be_falsey }
      end

      context "when the reg_no does not exist" do
        it { expect(subject).to be_truthy }
      end
    end

    context "validating the format of the reg_no" do
      let(:reg_no) { SequenceNumber::Generator.reg_no!(part) }

      context "in the part_1 format" do
        let(:part) { :part_1 }
        it { expect(subject).to be_falsey }
      end

      context "in the part_2 format" do
        let(:part) { :part_2 }
        it { expect(subject).to be_falsey }
      end

      context "in the part_3 format" do
        let(:part) { :part_3 }
        it { expect(subject).to be_falsey }
      end

      context "in the part_4 format" do
        let(:part) { :part_4 }
        it { expect(subject).to be_falsey }
      end
    end
  end
end
