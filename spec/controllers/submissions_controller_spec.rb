require "rails_helper"

describe SubmissionsController, type: :controller do
  before do
    allow(controller).to receive(:signed_in?).and_return(true)
    allow(controller).to receive(:current_user).and_return(current_user)
  end

  let!(:current_user) { create(:user) }

  context "#claim" do
    before do
      post :claim, params: { id: create(:paid_submission).id }
    end

    it "assigns the claimant" do
      expect(assigns[:submission].claimant).to eq(current_user)
    end

    it "redirects to my tasks" do
      expect(response).to redirect_to(tasks_my_tasks_path)
    end

    context "#unclaim" do
      before do
        post :unclaim, params: { id: assigns[:submission].id }
      end

      it "unassigns the claimant" do
        expect(assigns[:submission].claimant).to be_nil
      end

      it "redirects to my tasks" do
        expect(response).to redirect_to(tasks_my_tasks_path)
      end
    end
  end

  context "#approve" do
    let(:submission) { create_completeable_submission! }

    context "succesfully" do
      before { post :approve, params: { id: submission.id } }

      it "completes the submission" do
        expect(assigns[:submission]).to be_completed
      end

      it "renders the completed page" do
        expect(response).to render_template("completed")
      end

      it "does not create a notification" do
        expect(Notification::Approval.all).to be_empty
      end
    end

    context "with an email notification" do
      before do
        params = { id: submission.id, email_certificate_of_registry: "on" }
        post :approve, params: params
      end

      it "creates a notification" do
        expect(Notification::Approval.count).to eq(1)
      end

      it "sets the notification#actioned_by" do
        expect(Notification::Approval.first.actioned_by).to eq(current_user)
      end
    end

    context "unsuccessfully" do
      before do
        allow_any_instance_of(NewRegistration)
          .to receive(:process_application).and_return(false)
        post :approve, params: { id: submission.id }
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
