require "rails_helper"

describe NotificationsController, type: :controller do
  before do
    allow(controller).to receive(:signed_in?).and_return(true)
    allow(controller).to receive(:current_user).and_return(current_user)
  end

  let!(:submission) { create_completeable_submission! }
  let!(:current_user) { submission.claimant }

  let(:notification_params) do
    {
      id: submission.id,
      notification: {
        subject: "hello",
        message: "something to tell you",
        due_by: 30.days.from_now
      }
    }
  end

  context "#reject" do
    before do
      post :reject, params: notification_params
    end

    it "sets the status to rejected" do
      expect(assigns(:submission)).to be_rejected
    end

    it "unassigns the claimant" do
      expect(assigns(:submission).claimant).to be_blank
    end

    it "creates a rejection notification" do
      expect(assigns(:submission).notifications.first).to be_a(Notification::Rejection)
    end

    it "redirects to my tasks" do
      expect(response).to redirect_to(tasks_my_tasks_path)
    end
  end

  context "#refer" do
    before do
      post :refer, params: notification_params
    end

    it "sets the status to referred" do
      expect(assigns(:submission)).to be_referred
    end

    it "sets the referred_until date in the submission" do
      expect(assigns(:submission).referred_until).to be_present
    end

    it "unassigns the claimant" do
      expect(assigns(:submission).claimant).to be_blank
    end

    it "creates a referral notification" do
      expect(assigns(:submission).notifications.first).to be_a(Notification::Referral)
    end

    it "redirects to my tasks" do
      expect(response).to redirect_to(tasks_my_tasks_path)
    end
  end
end
