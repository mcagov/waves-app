require "rails_helper"

describe Builders::AssignedSubmissionBuilder do
  context ".create" do
    let!(:registered_vessel) { create(:registered_vessel) }
    let!(:claimant) { create(:user) }

    let(:submission) do
      described_class.create(
        :registrar_closure, :part_3, registered_vessel, claimant)
    end

    it "builds an assigned submission" do
      expect(submission).to be_assigned
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

    it "builds declarations with state :not_required" do
      expect(submission.declarations.map(&:current_state))
        .to eq([:not_required])
    end
  end
end
