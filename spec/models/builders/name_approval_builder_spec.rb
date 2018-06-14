require "rails_helper"

describe Builders::NameApprovalBuilder do
  let(:submission) { build(:submission, part: part) }

  let(:name_approval) do
    Submission::NameApproval.new(
      part: part,
      name: "BOBS BOAT",
      port_code: "SU",
      port_no: port_no,
      registration_type: "provisional")
  end

  before { Builders::NameApprovalBuilder.create(submission, name_approval) }

  context "for a part_2 submission that uses port_no" do
    let(:part) { :part_2 }

    context "in general" do
      let(:port_no) { 1234 }

      it "assigns the port_no" do
        expect(name_approval.port_no).to eq(1234)
      end

      it "assigns approved_until" do
        expect(name_approval.approved_until.to_date)
          .to eq(Time.zone.today.advance(months: 3))
      end

      it "assigns the submission vessel (in the changeset)" do
        vessel = name_approval.submission.vessel
        expect(vessel.name).to eq("BOBS BOAT")
        expect(vessel.port_code).to eq("SU")
        expect(vessel.port_no).to eq(1234)
        expect(vessel.registration_type).to eq("provisional")
      end
    end

    context "without a port_no" do
      let(:port_no) { nil }

      it "generates the next available port_no" do
        expect(name_approval.port_no).to eq(1)
      end
    end
  end

  context "for a part_1 submission that does not use port_no" do
    let(:part) { :part_1 }
    let(:port_no) { nil }

    it "does not assign a port_no" do
      expect(name_approval.port_no).to be_blank
    end

    it "assigns approved_until" do
      expect(name_approval.approved_until.to_date)
        .to eq(Time.zone.today.advance(months: 3))
    end

    it "assigns the submission vessel (in the changeset)" do
      vessel = name_approval.submission.vessel
      expect(vessel.name).to eq("BOBS BOAT")
      expect(vessel.port_code).to eq("SU")
      expect(vessel.registration_type).to eq("provisional")
    end
  end
end
