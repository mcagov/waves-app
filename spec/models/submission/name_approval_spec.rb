require "rails_helper"

describe Submission::NameApproval do
  let(:name_approval) do
    build(:submission_name_approval,
          part: :part_2,
          name: "BOBS BOAT",
          port_code: "SU",
          port_no: 1234)
  end

  context "#valid?" do
    before do
      expect(VesselNameValidator)
        .to receive(:valid?).with("part_2", "BOBS BOAT", "SU")

      expect(VesselPortNoValidator)
        .to receive(:valid?).with("part_2", 1234, "SU")
    end

    it { name_approval.valid? }
  end

  context "skipping validation" do
    context "when the name/port_code has not changed" do
      before do
        name_approval.submission.update_attributes(
          changeset: { vessel_info:
            Submission::Vessel.new(name: "BOBS BOAT", port_code: "SU") })

        expect(VesselNameValidator).not_to receive(:valid?)
      end

      it { name_approval.valid? }
    end

    context "when the port_no/port_code has not changed" do
      before do
        name_approval.submission.update_attributes(
          changeset: { vessel_info:
            Submission::Vessel.new(port_no: 1234, port_code: "SU") })

        expect(VesselPortNoValidator).not_to receive(:valid?)
      end

      it { name_approval.valid? }
    end
  end

  context ".port_name" do
    it { expect(name_approval.port_name).to eq("SOUTHAMPTON") }
  end
end
