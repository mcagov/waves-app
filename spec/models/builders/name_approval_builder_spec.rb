require "rails_helper"

describe Builders::NameApprovalBuilder do
  let(:submission) { build(:submission) }

  let(:name_approval) do
    Submission::NameApproval.new(
      part: :part_2,
      name: "BOBS BOAT",
      port_code: "SU",
      port_no: port_no,
      registration_type: "provisional")
  end

  before { Builders::NameApprovalBuilder.create(submission, name_approval) }

  context "in general" do
    let(:port_no) { 1234 }

    it "assigns the port_no" do
      expect(name_approval.port_no).to eq(1234)
    end

    it "assigns approved_until" do
      expect(name_approval.approved_until.to_date)
        .to eq(Date.today.advance(months: 3))
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
