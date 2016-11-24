require "rails_helper"

describe Submission::StatesController, type: :controller do
  before do
    sign_in claimant
  end

  let!(:claimant) { create(:user) }

  context "#claim" do
    before do
      post :claim,
           params: {
             submission_id: create(:unassigned_submission).id }, xhr: true
    end

    it "assigns the claimant" do
      expect(assigns[:submission].claimant).to eq(claimant)
    end

    it "renders the claim_button js" do
      expect(response).to render_template("tasks/actions/claim_button")
    end

    context "#unclaim" do
      before do
        post :unclaim,
             params: { submission_id: assigns[:submission].id }, xhr: true
      end

      it "unassigns the claimant" do
        expect(assigns[:submission].claimant).to be_nil
      end

      it "renders the claim_button js" do
        expect(response).to render_template("tasks/actions/claim_button")
      end
    end
  end

  context "#claim_referral" do
    before do
      post :claim_referral,
           params: { submission_id: create(:referred_submission).id }
    end

    it "assigns the claimant" do
      expect(assigns[:submission].claimant).to eq(claimant)
    end

    it "sets the status to assigned" do
      expect(assigns[:submission]).to be_assigned
    end
  end
end
