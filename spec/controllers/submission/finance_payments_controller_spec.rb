require "rails_helper"

describe Submission::FinancePaymentsController, type: :controller do
  before do
    sign_in claimant
  end

  let!(:claimant) { create(:user) }

  describe "#convert" do
    let!(:submission) { create(:finance_payment).submission }

    before do
      submission.update_attributes(state: :assigned, task: task)

      patch :convert, params: { submission_id: submission.id }
    end

    context "for a new_registration" do
      let(:task) { :new_registration }

      it "officer intervention is no longer required" do
        expect(submission.reload.officer_intervention_required).to be_falsey
      end

      it "redirects to submission#show" do
        expect(response).to redirect_to(submission_path(submission))
      end

      it "generates the ref_no" do
        expect(submission.reload.ref_no).to be_present
      end
    end

    context "for change_vessel and there is no vessel" do
      let(:task) { :change_vessel }

      it "renders #edit" do
        expect(response).to render_template(:edit)
      end

      it "officer intervention is still required" do
        expect(submission.reload.officer_intervention_required).to be_truthy
      end
    end
  end

  describe "#update" do
    let!(:submission) { create(:submission, state: :assigned) }

    context "for a valid change_vessel" do
      let!(:registered_vessel) { create(:registered_vessel) }

      before do
        patch :update,
              params: {
                submission_id: submission.id,
                submission: {
                  task: :change_vessel,
                  vessel_reg_no: registered_vessel.reg_no } }
      end

      it "redirects_to submissions#show" do
        expect(response).to redirect_to(submission_path(submission))
      end
    end

    context "when the vessel is invalid" do
      before do
        patch :update,
              params: {
                submission_id: submission.id,
                submission: {
                  task: :change_vessel,
                  vessel_reg_no: "foo" } }
      end

      it "renders the edit template" do
        expect(response).to render_template(:edit)
      end

      it "ensures the officer_intervention_required is true" do
        expect(assigns(:submission).officer_intervention_required).to be_truthy
      end
    end
  end
end
