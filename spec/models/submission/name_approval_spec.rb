require "rails_helper"

describe Submission::NameApproval do
  let(:name_approval) do
    build(:submission_name_approval,
          part: :part_2,
          name: "BOBS BOAT",
          port_code: "SU",
          port_no: 1234,
          registration_type: :simple)
  end

  context "#valid?" do
    before do
      expect(VesselNameValidator)
        .to receive(:valid?).with("part_2", "BOBS BOAT", "SU", "simple")

      expect(VesselPortNoValidator)
        .to receive(:valid?).with(1234, "SU")
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

  context ".active" do
    subject { described_class.active }

    context "when the name_approval is active" do
      before do
        name_approval.save
      end

      it { expect(subject).to include(name_approval) }
    end

    context "when #approved_until has expired" do
      before do
        name_approval.approved_until = 1.day.ago
        name_approval.save
      end

      it { expect(subject).not_to include(name_approval) }
    end

    context "when #cancelled_at has been set" do
      before do
        name_approval.cancelled_at = Time.now
        name_approval.save
      end

      it { expect(subject).not_to include(name_approval) }
    end
  end
end
