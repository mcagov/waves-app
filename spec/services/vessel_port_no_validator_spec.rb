require "rails_helper"

describe VesselPortNoValidator do
  context "#valid?" do
    subject { described_class.valid?(:part_1, 123, "SU") }

    let(:part) { :part_1 }
    let(:port_no) { 123 }
    let(:port_code) { "SU" }

    it { expect(subject).to be_truthy }

    context "with a registered_vessel with the same port_no" do
      before do
        create(
          :registered_vessel,
          part: part, port_no: port_no, port_code: port_code)
      end

      context "in a different port" do
        let(:port_code) { "AA" }
        it { expect(subject).to be_truthy }
      end

      context "in the same port" do
        it { expect(subject).to be_falsey }
      end

      context "in a different part of the register" do
        let(:part) { :part_4 }
        it { expect(subject).to be_truthy }
      end
    end

    context "with a name_approval with the same port_no" do
      before do
        create(
          :submission_name_approval,
          part: part, port_no: port_no,
          port_code: port_code, approved_until: approved_until)
      end

      let(:approved_until) { 1.day.from_now }

      context "in the same port" do
        it { expect(subject).to be_falsey }
      end

      context "in a different port" do
        let(:port_code) { "AA" }
        it { expect(subject).to be_truthy }
      end

      context "in a different part of the register" do
        let(:part) { :part_4 }
        it { expect(subject).to be_truthy }
      end

      context "when approved_until has expired" do
        let(:approved_until) { 2.days.ago }
        it { expect(subject).to be_truthy }
      end
    end
  end
end
