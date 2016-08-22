require "rails_helper"

describe SubmissionsController, type: :controller do
  before do
    allow(controller).to receive(:signed_in?).and_return(true)
    allow(controller).to receive(:current_user).and_return(current_user)
  end

  let!(:current_user) { create(:user) }

  context "#claim" do
    before do
      post :claim, params: {id: create(:paid_submission).id}
    end

    it "assigns the claimant" do
      expect(assigns[:submission].claimant).to eq(current_user)
    end

    it "redirects to the submission page" do
      expect(response).to redirect_to(submission_path(assigns[:submission]))
    end


    context "#unclaim" do
      before do
        post :unclaim, params: {id: assigns[:submission].id}
      end

      it "unassigns the claimant" do
        expect(assigns[:submission].claimant).to be_nil
      end

      it "redirects to my tasks " do
        expect(response).to redirect_to(tasks_my_tasks_path)
      end
    end
  end
end
