require "rails_helper"

describe SubmissionVesselController, type: :controller do
  before do
    allow(controller).to receive(:signed_in?).and_return(true)
    allow(controller).to receive(:current_user).and_return(current_user)
  end

  let!(:current_user) { create(:user) }
  let!(:submission) { create_incomplete_submission! }

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
