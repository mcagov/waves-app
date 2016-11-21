require "rails_helper"

describe NotificationsController, type: :controller do
  before do
    sign_in claimant
  end

  let!(:submission) { create(:assigned_submission) }
  let!(:claimant) { submission.claimant }

  let(:notification_params) do
    {
      id: submission.id,
      notification: {
        subject: "hello",
        message: "something to tell you",
        actionable_at: 30.days.from_now,
      },
    }
  end

  context "#cancel" do
    before do
      post :cancel, params: notification_params
    end

    it "sets the status to cancelled" do
      expect(assigns(:submission)).to be_cancelled
    end

    it "unassigns the claimant" do
      expect(assigns(:submission).claimant).to be_blank
    end

    it "sets the cancellation actioned_by" do
      expect(assigns(:submission).cancellation.actioned_by).to eq(claimant)
    end

    it "redirects to my tasks" do
      expect(response).to redirect_to(tasks_my_tasks_path)
    end

    it "creates a notification for the correspondent" do
      expect(Notification::Cancellation.count).to eq(1)
      expect(Notification::Cancellation.last.recipient_email)
        .to eq(submission.correspondent.email)
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

    it "sets the referral actioned_by" do
      expect(assigns(:submission).referral.actioned_by).to eq(claimant)
    end

    it "redirects to my tasks" do
      expect(response).to redirect_to(tasks_my_tasks_path)
    end

    it "creates one notification addressed to the correspondent" do
      expect(Notification::Referral.count).to eq(1)
      expect(Notification::Referral.last.recipient_email)
        .to eq(submission.correspondent.email)
    end
  end
end
