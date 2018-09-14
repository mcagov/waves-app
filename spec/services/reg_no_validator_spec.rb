require "rails_helper"

describe RegNoValidator do
  context "#valid?" do
    subject { described_class.valid?(reg_no, part) }

    context "validating the existince of a given reg_no" do
      let(:reg_no) { "MY_REG_NO" }

      context "when the reg_no exists in that part" do
        let(:part) { :part_3 }

        before do
          create(:registered_vessel).update_attributes(reg_no: "MY_REG_NO")
        end

        it { expect(subject).to be_falsey }
      end

      context "when the reg_no exists in another part" do
        let(:part) { :part_3 }

        before do
          create(:pleasure_vessel).update_attributes(reg_no: "MY_REG_NO")
        end

        it { expect(subject).to be_truthy }
      end

      context "when the reg_no exists in part_4" do
        let(:part) { :part_4 }

        before do
          create(:part_4_vessel).update_attributes(reg_no: "MY_REG_NO")
        end

        it { expect(subject).to be_truthy }
      end

      context "when the reg_no does not exist" do
        let(:part) { :part_3 }

        it { expect(subject).to be_truthy }
      end
    end

    context "validating the format of the reg_no" do
      context "in the sequence" do
        let(:reg_no) { "C30001" }
        let(:part) { :part_2 }

        it { expect(subject).to be_falsey }
      end

      context "in the format but not the sequence (lower number)" do
        let(:reg_no) { "C29999" }
        let(:part) { :part_2 }

        it { expect(subject).to be_truthy }
      end
    end

    context "checking case sensitivity" do
      let(:invalid_reg_no) { "ssr200001" }

      context "lower case" do
        let(:reg_no) { invalid_reg_no }
        let(:part) { :part_3 }

        it { expect(subject).to be_falsey }
      end

      context "upper case" do
        let(:reg_no) { invalid_reg_no.upcase }
        let(:part) { :part_3 }

        it { expect(subject).to be_falsey }
      end
    end
  end
end
