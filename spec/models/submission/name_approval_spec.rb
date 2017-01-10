require "rails_helper"

describe Submission::NameApproval do
  context ".valid?" do
    let!(:registered_vessel) do
      create(:registered_vessel,
             part: :part_2,
             name: "BOBS BOAT",
             name_approved_until: name_approved_until,
             port_code: "SU",
             port_no: 1234)
    end
    let(:name_approved_until) { 1.day.ago }

    let(:name_approval) do
      Submission::NameApproval.new(
        name: "BOBS BOAT",
        part: name_approval_part,
        port_code: name_approval_port_code,
        port_no: name_approval_port_no)
    end

    let(:name_approval_part) { :part_2 }
    let(:name_approval_port_code) { "SU" }
    let(:name_approval_port_no) { 1234 }
    let(:name_approved_until) { 2.days.from_now }

    before { name_approval.valid? }

    context "in the same port" do
      context "when the other vessel's name reservation is current" do
        it { expect(name_approval.errors).to include(:name) }
      end

      context "when the other vessel's name reservation has expired" do
        let(:name_approved_until) { 1.day.ago }

        it { expect(name_approval.errors).not_to include(:name) }
      end

      context "when the port_no is in use for that port" do
        it { expect(name_approval.errors).to include(:port_no) }
      end

      context "when the port_no is not in use for that port" do
        let(:name_approval_port_no) { 5678 }

        it { expect(name_approval.errors).not_to include(:port_no) }
      end
    end

    context "in a different port" do
      let(:name_approval_port_code) { "A" }

      context "the name is valid" do
        it { expect(name_approval.errors).not_to include(:name) }
      end

      context "the port_no is valid" do
        it { expect(name_approval.errors).not_to include(:port_no) }
      end
    end

    context "in a different part of the registry" do
      let(:name_approval_part) { :part_1 }

      context "the name is valid" do
        it { expect(name_approval.errors).not_to include(:name) }
      end

      context "the port_no is valid" do
        it { expect(name_approval.errors).not_to include(:port_no) }
      end
    end

    context "with an invalid port_no" do
      let(:name_approval_port_no) { "A1" }
      it { expect(name_approval.errors).to include(:port_no) }
    end

    context "with an blank port_no" do
      let(:name_approval_port_no) { "" }
      it { expect(name_approval.errors).not_to include(:port_no) }
    end
  end
end
