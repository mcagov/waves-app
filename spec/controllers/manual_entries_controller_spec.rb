require "rails_helper"

describe ManualEntriesController, type: :controller do
  before do
    sign_in claimant
  end

  let!(:claimant) { create(:user) }

  describe "#convert_to_application" do
    let!(:submission) { create(:finance_payment).submission }

    before do
      submission.update_attributes(state: :assigned, task: task)

      post :convert_to_application, params: { id: submission.id }
    end

    context "for a new_registration" do
      let(:task) { :new_registration }

      it "officer intervention is no longer required" do
        expect(submission.reload.officer_intervention_required).to be_falsey
      end

      it "redirects to submission#edit" do
        expect(response).to redirect_to(edit_submission_path(submission))
      end

      it "generates the ref_no" do
        expect(submission.reload.ref_no).to be_present
      end
    end

    context "for change_registry_details and there is no vessel" do
      let(:task) { :change_registry_details }

      it "render manual_entries#edit" do
        expect(response).to render_template(:edit)
      end

      it "officer intervention is still required" do
        expect(submission.reload.officer_intervention_required).to be_truthy
      end
    end
  end

  describe "#create" do
    context "successfully" do
      before do
        post :create,
             params: { submission: { task: :new_registration, part: :part_1 } }
      end

      it "sets the part" do
        expect(assigns(:submission).part.to_sym).to eq(:part_1)
      end

      it "sets the claimant (and we can assume it is assigned)" do
        expect(assigns(:submission).claimant).to eq(claimant)
      end

      it "sets the source" do
        expect(assigns(:submission).source.to_sym).to eq(:manual_entry)
      end
    end
  end

  describe "#update" do
    let!(:submission) { create(:submission, state: :assigned) }

    context "for a valid change_registry_details" do
      let!(:registered_vessel) { create(:registered_vessel) }

      before do
        patch :update,
              params: {
                id: submission.id,
                submission: {
                  task: :change_registry_details,
                  vessel_reg_no: registered_vessel.reg_no } }
      end

      it "redirects_to submissions#show" do
        expect(response).to redirect_to(submission_path(submission))
      end
    end

    context "for a new_registration" do
      before do
        patch :update,
              params: {
                id: submission.id,
                submission: { task: :new_registration } }
      end

      it "redirects_to submissions#edit" do
        expect(response).to redirect_to(edit_submission_path(submission))
      end
    end

    context "when the part changes" do
      before do
        patch :update, params: {
          id: submission.id,
          submission: { part: :part_4 } }
      end

      it "redirects_to submissions#edit" do
        expect(response).to redirect_to(tasks_my_tasks_path)
      end
    end
  end
end
