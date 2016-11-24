require "rails_helper"

describe Submission::ApprovalsController, type: :controller do
  before do
    sign_in claimant
  end

  let!(:claimant) { create(:user) }

  context "#create" do
    let(:submission) { create(:assigned_submission) }
    let(:params) { { submission_id: submission.id } }

    context "succesfully" do
      before { post :create, params: params }

      it "moves the submission to :printing" do
        expect(assigns[:submission]).to be_printing
      end

      it "renders the aproved page" do
        expect(response).to render_template("approved")
      end

      it "creates a notification for the applicant" do
        expect(Notification::ApplicationApproval.count).to eq(1)

        expect(Notification::ApplicationApproval.first.recipient_name)
          .to eq(submission.applicant_name)

        expect(Notification::ApplicationApproval.first.recipient_email)
          .to eq(submission.applicant_email)
      end

      it "sets the notification#actioned_by" do
        expect(Notification::ApplicationApproval.first.actioned_by)
          .to eq(claimant)
      end
    end

    context "when printing is not required" do
      before do
        allow_any_instance_of(Submission)
          .to receive(:printing_required?)
          .and_return(false)

        post :create, params: params
      end

      it "moves the submission to :completed" do
        expect(assigns[:submission]).to be_completed
      end

      it "renders the aproved page" do
        expect(response).to render_template("approved")
      end

      it "creates a notification for the applicant" do
        expect(Notification::ApplicationApproval.count).to eq(1)
      end

      it "sets the notification#actioned_by" do
        expect(Notification::ApplicationApproval.first.actioned_by)
          .to eq(claimant)
      end
    end

    context "unsuccessfully" do
      before do
        allow_any_instance_of(Submission)
          .to receive(:move_to_print_queue!).and_return(false)
        post :create, params: params
      end

      it "is still :assigned" do
        expect(assigns[:submission]).to be_assigned
      end

      it "renders the errors page" do
        expect(response).to render_template("errors")
      end
    end
  end
end
