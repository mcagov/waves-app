require "rails_helper"

describe Submission::DocumentsController, type: :controller do
  before do
    sign_in user
  end

  let!(:user) { create(:user) }

  before do
    post :create, params: {
      submission_id: create(:submission).id,
      task_id: task.id,
      document: { content: "foo" } }
  end

  context "#create" do
    context "when the task is #referred" do
      let(:task) { create(:referred_task) }

      it "moves to #unclaimed" do
        expect(assigns(:task)).to be_unclaimed
      end

      it { creates_a_work_log_entry("Submission::Task", :document_added) }
    end

    context "when the task is #cancelled" do
      let(:task) { create(:cancelled_task) }

      it "remains to #cancelled" do
        expect(assigns(:task)).to be_cancelled
      end

      it { creates_a_work_log_entry("Submission::Task", :document_added) }
    end

    context "when the task is #claimed" do
      let(:task) { create(:claimed_task, claimant: user) }

      it "remains #claimed" do
        expect(assigns(:task)).to be_claimed
      end

      it { creates_a_work_log_entry("Submission::Task", :document_added) }
    end
  end
end
