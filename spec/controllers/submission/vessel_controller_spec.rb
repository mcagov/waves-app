require "rails_helper"

describe Submission::VesselController, type: :controller do
  before do
    sign_in claimant
  end

  let!(:claimant) { create(:user) }
  let!(:submission) { create(:incomplete_submission) }

  context "#update" do
    before do
      put :update, params: {
        submission_id: submission.id,
        vessel: { name: "Bob's Boat" } }, xhr: true
    end

    it "updates the submission" do
      expect(submission.reload.vessel.name).to eq("BOB'S BOAT")
    end

    it "returns status 204 (as expected by bootstrap-editable" do
      expect(response).to have_http_status(204)
    end
  end
end
