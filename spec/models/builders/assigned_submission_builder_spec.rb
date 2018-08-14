require "rails_helper"

describe Builders::AssignedSubmissionBuilder do
  xcontext ".create" do
    let!(:registered_vessel) { create(:registered_vessel) }
    let!(:claimant) { create(:user) }

    let(:submission) do
      described_class.create(
        :registrar_closure, :part_3, registered_vessel, claimant)
    end

    it "persists the record" do
      expect(submission).to be_persisted
    end

    it "builds an assigned submission" do
      expect(submission).to be_assigned
    end

    it "assigns the task" do
      expect(submission.task.to_sym).to eq(:registrar_closure)
    end

    it "is a manual_entry" do
      expect(submission.source.to_sym).to eq(:manual_entry)
    end

    it "has a ref_no" do
      expect(submission.ref_no).to be_present
    end

    it "assigns the claimant" do
      expect(submission.claimant).to eq(claimant)
    end

    it "assigns the vessel (as changeset)" do
      expect(submission.vessel.name).to eq(registered_vessel.name)
    end

    it "assigns the registered_vessel" do
      expect(submission.registered_vessel).to eq(registered_vessel)
    end

    it "builds the agent" do
      expect(submission.agent.name).to eq(registered_vessel.agent.name)
    end

    it "builds the agent" do
      expect(submission.agent.name).to eq(registered_vessel.agent.name)
    end

    it "builds the mortgages" do
      expect(submission.mortgages.count).to eq(1)
    end

    it "builds the engines" do
      expect(submission.engines.count).to eq(1)
    end
  end
end
