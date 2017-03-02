require "rails_helper"

describe Submission::NameApproval do
  context ".create" do
    before do
      vessel_name_validator = double(:vessel_name_validator)
      expect(VesselNameValidator)
        .to receive(:new).twice.and_return(vessel_name_validator)

      expect(vessel_name_validator).to receive(:name_in_use?)
      expect(vessel_name_validator).to receive(:port_no_in_use?)
    end

    let(:name_approval) do
      described_class.create(
        submission: create(:submission),
        part: :part_2,
        name: "BOBS BOAT",
        port_code: "SU",
        port_no: port_no,
        registration_type: "full")
    end

    let(:port_no) { 1234 }

    it "sets the approved_until" do
      expect(name_approval.approved_until.to_date)
        .to be_between(89.days.from_now, 91.days.from_now)
    end

    it "sets the submission vessel (in the changeset)" do
      vessel = name_approval.submission.vessel
      expect(vessel.name).to eq("BOBS BOAT")
      expect(vessel.port_code).to eq("SU")
      expect(vessel.port_no).to eq(1234)
      expect(vessel.registration_type).to eq("full")
    end

    context "without a port_no" do
      let(:port_no) { nil }

      it { expect(name_approval.port_no).to be_present }
    end
  end

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
  end
end
