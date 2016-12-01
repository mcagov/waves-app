require "rails_helper"

describe Submission::DocumentsController, type: :controller do
  before do
    sign_in user
  end

  let!(:user) { create(:user) }

  before do
    post :create, params: {
      submission_id: submission.id, document: { content: "foo" } }
  end

  context "#create" do
    context "when the submission is #referred" do
      let(:submission) { create(:referred_submission) }

      it "moves to #unassigned" do
        expect(assigns(:submission)).to be_unassigned
      end

      it { creates_a_work_log_entry("Document", :document_entry) }
    end

    context "when the submission is #cancelled" do
      let(:submission) { create(:cancelled_submission) }

      it "remains to #cancelled" do
        expect(assigns(:submission)).to be_cancelled
      end

      it { creates_a_work_log_entry("Document", :document_entry) }
    end

    context "when the submission is #incomplete" do
      let(:submission) { create(:incomplete_submission) }

      it "remains #incomplete (#check_current_state still be called)" do
        expect(assigns(:submission)).to be_incomplete
      end

      it { creates_a_work_log_entry("Document", :document_entry) }
    end

    context "when the submission is #assigned" do
      let(:submission) { create(:assigned_submission, claimant: user) }

      it "remains #assigned" do
        expect(assigns(:submission)).to be_assigned
      end

      it { creates_a_work_log_entry("Document", :document_entry) }
    end
  end
end
