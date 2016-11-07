require "rails_helper"

describe Builders::RegistryBuilder do
  context ".create" do
    before { described_class.create(submission) }

    let!(:submission) do
      create(:assigned_submission,
             changeset: {
               vessel_info: build(:submission_vessel, vessel_type: "BARGE"),
               owners: [{ name: "ALICE" }, { name: "BOB" }],
             })
    end

    let(:registered_vessel) { submission.reload.registered_vessel }

    it "creates the expected vessel type" do
      expect(registered_vessel.vessel_type).to eq("BARGE")
    end

    it "sets the registry part" do
      expect(registered_vessel.part.to_sym).to eq(:part_3)
    end

    it "creates registered owners in the expect order" do
      expect(registered_vessel.owners.length).to eq(2)
      expect(registered_vessel.owners.first.name).to eq("ALICE")
      expect(registered_vessel.owners.last.name).to eq("BOB")
    end

    it "can find or create vessel and owners"
  end
end
