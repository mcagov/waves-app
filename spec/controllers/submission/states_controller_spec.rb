require "rails_helper"

describe Submission::StatesController, type: :controller do
  before do
    allow(controller).to receive(:signed_in?).and_return(true)
    allow(controller).to receive(:current_user).and_return(current_user)
  end

  let!(:current_user) { create(:user) }

  context "#claim" do
    before do
      post :claim,
           params: { submission_id: create(:paid_submission).id }, xhr: true
    end

    it "assigns the claimant" do
      expect(assigns[:submission].claimant).to eq(current_user)
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
      expect(assigns[:submission].claimant).to eq(current_user)
    end

    it "sets the status to assigned" do
      expect(assigns[:submission]).to be_assigned
    end
  end

  context "#approve" do
    let(:submission) { create_assigned_submission! }

    context "succesfully" do
      before { post :approve, params: { submission_id: submission.id } }

      it "moves the submission to :printing" do
        expect(assigns[:submission]).to be_printing
      end

      it "renders the aproved page" do
        expect(response).to render_template("approved")
      end

      it "creates a notification for each owner" do
        expect(Notification::ApplicationApproval.count).to eq(2)
      end

      it "sets the notification#actioned_by" do
        expect(Notification::ApplicationApproval.first.actioned_by)
          .to eq(current_user)
      end
    end

    context "unsuccessfully" do
      before do
        allow_any_instance_of(Submission)
          .to receive(:approved!).and_return(false)
        post :approve, params: { submission_id: submission.id }
      end

      it "does not move to completed" do
        expect(assigns[:submission]).not_to be_completed
      end

      it "renders the errors page" do
        expect(response).to render_template("errors")
      end
    end
  end
end