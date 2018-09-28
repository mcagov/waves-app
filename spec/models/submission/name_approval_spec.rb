require "rails_helper"

describe Submission::NameApproval do
  let(:part) { :part_2 }

  context "with a new record" do
    let(:name_approval) do
      build(:name_approval,
            part: part,
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

      context "when #cancelled_at has been set" do
        before do
          name_approval.cancelled_at = Time.zone.now
          name_approval.save
        end

        it { expect(subject).not_to include(name_approval) }
      end
    end
  end

  context "for a persisted record" do
    let(:name_approval) do
      create(:name_approval,
             part: part,
             name: "BOBS BOAT",
             port_code: "SU",
             port_no: 1234,
             registration_type: :simple)
    end

    context "when the name has changed" do
      before do
        name_approval.submission.update_attributes(
          changeset: { vessel_info:
            Submission::Vessel.new(name: "ALICES BOAT", port_code: "SU") })

        expect(VesselNameValidator).to receive(:valid?)
      end

      it { name_approval.valid? }
    end

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

    context "when the port_no is blank (if port_no is not in use)" do
      before do
        name_approval.port_no = nil
        expect(VesselPortNoValidator).not_to receive(:valid?)
      end

      it { name_approval.valid? }
    end

    context "for a part_1 submission" do
      let(:part) { :part_1 }

      context "when the name has changed" do
        before do
          name_approval.submission.update_attributes(
            changeset: { vessel_info:
              Submission::Vessel.new(name: "NEW NAME", port_code: "SU") })

          expect(VesselNameValidator).to receive(:valid?)
        end

        it { name_approval.valid? }
      end

      context "when the port_code has changed, but the name has not" do
        before do
          name_approval.submission.update_attributes(
            changeset: { vessel_info:
              Submission::Vessel.new(name: "BOBS BOAT", port_code: "AR") })

          expect(VesselNameValidator).not_to receive(:valid?)
        end

        it { name_approval.valid? }
      end
    end
  end

  context "validations" do
    let(:name_approval) do
      build(:name_approval, part: part, port_code: "")
    end

    before { name_approval.valid? }

    context "part_2" do
      it { expect(name_approval.errors).to include(:port_code) }
    end

    context "part_1" do
      let(:part) { :part_1 }
      it { expect(name_approval.errors).not_to include(:port_code) }
    end
  end
end
