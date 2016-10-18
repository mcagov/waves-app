require "rails_helper"

describe "Submission Transitions", type: :model do
  context "state machine transitions" do
    context "to unassigned" do
      let!(:submission) { create_incomplete_submission! }
      let!(:payment) { Payment.create(amount: 100, submission: submission) }

      before do
        allow(Policies::Submission)
          .to receive(:actionable?)
          .with(submission)
          .and_return(true)

        expect(Builders::ProcessingDatesBuilder)
          .to receive(:create)
          .with(submission, payment.amount)
      end

      it { submission.paid! }
    end

    context "to assigned" do
      let!(:submission) { create_unassigned_submission! }
      let!(:bob) { create(:user) }

      before { submission.claimed!(bob) }

      it { expect(submission.claimant).to eq(bob) }
    end

    context "from assigned to unassigned" do
      let!(:submission) { create_assigned_submission! }
      let!(:bob) { create(:user) }

      before { submission.unclaimed! }

      it { expect(submission.claimant).to be_nil }
    end

    context "from assigned to referred" do
      let!(:submission) { create_assigned_submission! }

      before { submission.referred! }

      it { expect(submission.claimant).to be_nil }
    end

    context "from referred to unassigned" do
      let!(:submission) { create_referred_submission! }

      before { submission.unreferred! }

      it { expect(submission.claimant).to be_nil }
    end

    context "to printing" do
      let!(:submission) { create_assigned_submission! }
      let(:registration_starts_at) { Time.now }

      before do
        expect(Policies::Submission)
          .to receive(:approvable?)
          .with(submission)
          .and_return(true)

        expect(Builders::NewRegistrationBuilder)
          .to receive(:create)
          .with(submission, registration_starts_at)
      end

      it { submission.approved!(registration_starts_at) }
    end

    context "to completed" do
      let!(:submission) { create_printing_submission! }

      before do
        allow(Policies::Submission)
          .to receive(:printing_completed?)
          .with(submission)
      end

      it { submission.printed! }
    end
  end
end
