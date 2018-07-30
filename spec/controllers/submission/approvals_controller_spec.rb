require "rails_helper"

describe Submission::ApprovalsController, type: :controller do
  before do
    sign_in claimant
  end

  let!(:claimant) { create(:user) }

  xdescribe "in general" do
    context "#create" do
      let(:submission) { create(:assigned_submission) }

      let(:approval_params) do
        {
          registration_starts_at: "1/1/2011",
          closure_at: "2/2/2022",
          closure_reason: "some text",
        }
      end

      let(:params) do
        {
          submission_id: submission.id,
          submission_approval: approval_params,
        }
      end

      context "successfully" do
        before do
          allow_any_instance_of(Submission)
            .to receive(:approved!)
            .with(approval_params)
            .and_return(true)

          post :create, params: params
        end

        it "redirect_to the show page" do
          expect(response).to be_redirect
        end

        it "creates a notification for the applicant" do
          expect(Notification::ApplicationApproval.count).to eq(1)
        end

        it "sets the notification#actioned_by" do
          expect(Notification::ApplicationApproval.first.actioned_by)
            .to eq(claimant)
        end

        it { creates_a_work_log_entry("Submission", :processed_application) }
      end

      context "unsuccessfully" do
        before do
          allow_any_instance_of(Submission)
            .to receive(:approved!).and_return(false)
          post :create, params: params
        end

        it "is still :assigned" do
          expect(assigns[:submission]).to be_assigned
        end

        it "renders the errors page" do
          expect(response).to render_template("errors")
        end

        it { does_not_create_a_work_log_entry }
      end
    end
  end
end
