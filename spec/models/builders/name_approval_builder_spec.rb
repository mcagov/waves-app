require "rails_helper"

describe Builders::NameApprovalBuilder do
  context ".create" do
    let(:name_approval) do
      Submission::NameApproval.new(
        name: "BOBS BOAT",
        part: :part_2,
        port_code: "SU",
        port_no: port_no,
        registration_type: :full)
    end

    subject do
      described_class.create(
        create(:submission, part: :part_2, task: :new_registration),
        name_approval)
    end

    let(:submission) { subject }
    let(:registered_vessel) { submission.registered_vessel }

    context "with valid data" do
      let(:port_no) { 123 }

      it "assigns the vessel reg_no" do
        expect(registered_vessel.reg_no).to be_present
      end

      it "saves the vessel port_no" do
        expect(registered_vessel.port_no).to eq(123)
      end

      it "saves the vessel name" do
        expect(registered_vessel.name).to eq("BOBS BOAT")
      end

      it "saves the vessel port_code" do
        expect(registered_vessel.port_code).to eq("SU")
      end

      it "saves the vessel registration_type" do
        expect(registered_vessel.registration_type).to eq("full")
      end

      it "sets the name_approved_until" do
        expect(registered_vessel.name_approved_until).to be_present
      end

      it "sets the submission vessel (in the changeset)" do
        expect(submission.reload.vessel.name).to eq("BOBS BOAT")
      end

      context "but no port_no" do
        let(:port_no) { nil }

        it { expect(registered_vessel.port_no).not_to be_blank }
      end
    end
  end
end
