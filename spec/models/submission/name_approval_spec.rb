require "rails_helper"

describe Submission::NameApproval do
  context ".create" do
    before do
      expect(VesselNameValidator)
        .to receive(:valid?).with("part_2", "BOBS BOAT", "SU")
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

    context "in general" do
      before do
        expect(VesselPortNoValidator)
          .to receive(:valid?).with("part_2", 1234, "SU")
      end

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
    end

    context "without a port_no" do
      before do
        expect(VesselPortNoValidator)
          .to receive(:valid?).with("part_2", 1, "SU")
      end

      let(:port_no) { nil }

      it { expect(name_approval.port_no).to be_present }
    end
  end
end
