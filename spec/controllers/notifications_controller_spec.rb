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
        message: "something to tell you"
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
      expect(assigns(:submission).claimant).to eq(current_user)
    end

    it "creates a rejection notification" do
      expect(assigns(:submission).notifications.first).to be_a(Notification::Rejection)
    end

    it "redirects to my tasks" do
      expect(response).to redirect_to(tasks_my_tasks_path)
    end
  end
end
