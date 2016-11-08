require "rails_helper"

describe Builders::RegistryBuilder do
  context ".create" do
    before { described_class.create(submission) }

    let!(:submission) do
      create(:assigned_submission,
             changeset: {
               vessel_info: build(:submission_vessel, name: "BOB BARGE"),
               owners: [{ name: "ALICE" }, { name: "BOB" }],
             })
    end

    let(:registered_vessel) { submission.reload.registered_vessel }

    it "creates the expected vessel name" do
      expect(registered_vessel.name).to eq("BOB BARGE")
    end

    it "sets the registry part" do
      expect(registered_vessel.part.to_sym).to eq(:part_3)
    end

    it "creates registered owners in the expect order" do
      expect(registered_vessel.owners.length).to eq(2)
      expect(registered_vessel.owners.first.name).to eq("ALICE")
      expect(registered_vessel.owners.last.name).to eq("BOB")
    end

    context "with a task that changes registry details" do
      let!(:change_details_submission) do
        create(:assigned_submission,
               task: :change_registry_details,
               registered_vessel: registered_vessel,
               changeset: {
                 vessel_info: build(:submission_vessel, name: "DON DINGHY"),
                 owners: [
                   { name: "ALICE" }, { name: "DAVE" }, { name: "ELLEN" }],
               })
      end

      before do
        described_class.create(change_details_submission)
        registered_vessel.reload
      end

      it "updates the vessel name" do
        expect(registered_vessel.name).to eq("DON DINGHY")
      end

      it "creates registered owners in the expect order" do
        expect(registered_vessel.owners.length).to eq(3)
        expect(registered_vessel.owners[0].name).to eq("ALICE")
        expect(registered_vessel.owners[1].name).to eq("DAVE")
        expect(registered_vessel.owners[2].name).to eq("ELLEN")
      end
    end
  end
end
