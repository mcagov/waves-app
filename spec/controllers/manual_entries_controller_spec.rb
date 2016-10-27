require "rails_helper"

describe ManualEntriesController, type: :controller do
  before do
    allow(controller).to receive(:signed_in?).and_return(true)
    allow(controller).to receive(:current_user).and_return(current_user)
  end

  let!(:current_user) { create(:user) }
  let!(:submission) { create(:finance_payment).submission }

  describe "#update" do
    before do
      submission.update_attribute(:task, task)
      post :convert_to_application, params: { id: submission.id }
    end

    context "for a new_registration" do
      before do
        allow(Builders::ManualEntryBuilder)
          .to receive(:convert_to_application)
          .with(submission)
          .and_return(submission)
      end

      let(:task) { :new_registration }

      it "officer intervention is no longer required" do
        expect(submission.reload.officer_intervention_required).to be_falsey
      end

      it "redirects to submission#edit" do
        expect(response).to redirect_to(edit_submission_path(submission))
      end
    end

    context "for change_vessel and there is no vessel" do
      let(:task) { :change_vessel }

      it "render manual_entries#edit" do
        expect(response).to render_template(:edit)
      end

      it "officer intervention is still required" do
        expect(submission.reload.officer_intervention_required).to be_truthy
      end
    end
  end
end
