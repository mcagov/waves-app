require "rails_helper"

describe Submission, type: :model do
  context "in general" do
    let!(:submission) { create_incomplete_submission! }

    it "gets the vessel_info" do
      expect(submission.vessel).to be_a(Submission::Vessel)
    end

    it "has a state: incomplete" do
      expect(submission).to be_incomplete
    end

    it "gets the delivery_address" do
      expect(submission.delivery_address.country).to eq("UNITED KINGDOM")
    end
  end

  context "#vessel_reg_no (for a change of vessel_details)" do
    let!(:registered_vessel) { create(:registered_vessel) }
    let!(:submission) do
      build(:submission,
            task: :change_vessel,
            vessel_reg_no: vessel_reg_no)
    end

    before { submission.save }

    context "for a vessel that exists" do
      let(:vessel_reg_no) { registered_vessel.reg_no }

      it "gets the vessel_reg_no" do
        expect(submission.vessel_reg_no).to eq(vessel_reg_no)
      end

      it "has a registered_vessel" do
        expect(submission.registered_vessel).to eq(registered_vessel)
      end
    end

    context "that is unknown" do
      let(:vessel_reg_no) { "bob" }

      it "has an error message on the vessel_reg_no" do
        expect(submission.errors).to include(:vessel_reg_no)
      end
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
