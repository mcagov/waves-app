require "rails_helper"

describe Submission, type: :model do
  context "in general" do
    let!(:submission) { create_incomplete_submission! }

    it "gets the vessel_info" do
      expect(submission.vessel).to be_a(Submission::Vessel)
    end

    it "get two declarations" do
      expect(submission.declarations.length).to eql(2)
    end

    it "has a state: incomplete" do
      expect(submission).to be_incomplete
    end

    it "has a ref_no with the expected prefix" do
      expect(submission.ref_no).to match(/3N-.*/)
    end

    it "has some declarations" do
      expect(submission.declarations).not_to be_empty
    end

    it "gets the delivery_address" do
      expect(submission.delivery_address.country).to eq("UNITED KINGDOM")
    end
  end

  context ".referred_until_expired" do
    let!(:submission) { create(:submission, referred_until: referred_until) }
    let(:submissions) { Submission.referred_until_expired }

    context "tomorrow" do
      let(:referred_until) { Date.tomorrow }
      it { expect(submissions).to be_empty }
    end

    context "today" do
      let(:referred_until) { Date.today }
      it { expect(submissions.length).to eq(1) }
    end

    context "yesterday" do
      let(:referred_until) { Date.yesterday }
      it { expect(submissions.length).to eq(1) }
    end

    context "nil" do
      let(:referred_until) { nil }
      it { expect(submissions).to be_empty }
    end
  end

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
          .with(submission)
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

      before do
        expect(Builders::ProcessingDatesBuilder)
          .to receive(:create)
          .with(submission)

        submission.unreferred!
      end

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
