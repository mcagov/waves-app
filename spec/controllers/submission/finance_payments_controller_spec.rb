require "rails_helper"

describe Submission::FinancePaymentsController, type: :controller do
  before do
    sign_in claimant
  end

  let!(:claimant) { create(:user) }

  describe "#convert" do
    let!(:submission) { create(:locked_finance_payment).submission }

    before do
      submission.update_attributes(state: :assigned, task: task)

      patch :convert, params: { submission_id: submission.id }
    end

    context "for a new_registration" do
      let(:task) { :new_registration }

      it "redirects to unclaimed tasks" do
        expect(response).to redirect_to(tasks_my_tasks_path)
      end

      it "generates the ref_no" do
        expect(submission.reload.ref_no).to be_present
      end

      it "sends an application_receipt email" do
        expect(Notification::ApplicationReceipt.count).to eq(1)
      end

      it "unassigns the submission" do
        expect(submission.reload).to be_unassigned
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
                  vessel_reg_no: registered_vessel.reg_no } }
      end

      it "redirects_to submissions#show" do
        expect(response).to redirect_to(submission_path(submission))
      end
    end
  end
end
