require "rails_helper"

describe Submission, type: :model do
  context "in general" do
    let!(:submission) { create(:incomplete_submission) }

    it "gets the vessel_info" do
      expect(submission.vessel).to be_a(Submission::Vessel)
    end

    it "has a state: incomplete" do
      expect(submission).to be_incomplete
    end

    it "gets the delivery_address" do
      expect(submission.delivery_address.country).to eq("UNITED KINGDOM")
    end

    context "changing the registered_vessel_id" do
      before do
        expect(Builders::SubmissionBuilder)
          .to receive(:build_defaults)
          .with(submission)
      end

      it "invokes the SubmissionBuilder#build_defaults" do
        submission.registered_vessel_id = create(:registered_vessel).id
        submission.save
      end
    end
  end

  context ".vessel_reg_no =" do
    let!(:registered_vessel) { create(:registered_vessel, part: vessel_part) }
    let(:submission) { create(:incomplete_submission, part: :part_1) }

    before { submission.vessel_reg_no = registered_vessel.reg_no }

    context "for a part_1 submission and a part_1 registered_vessel" do
      let(:vessel_part) { :part_1 }

      it { expect(submission.registered_vessel).to eq(registered_vessel) }
    end

    context "for a part_2 submission and a part_1 registered_vessel" do
      let(:vessel_part) { :part_2 }

      it { expect(submission.registered_vessel).to be_nil }
    end
  end

  context ".registered_vessel_exists" do
    let!(:submission) { build(:submission) }

    before do
      allow(Policies::Submission)
        .to receive(:registered_vessel_required?)
        .with(submission)
        .and_return(registered_vessel_required_policy)

      submission.save
    end

    context "when the registered_vessel_required? policy returns true" do
      let(:registered_vessel_required_policy) { true }

      it { expect(submission.errors).to include(:vessel_reg_no) }

      context "and the submission has a registered_vessel" do
        before do
          submission.vessel_reg_no = create(:registered_vessel).reg_no
        end

        it { expect(submission).to be_valid }
      end
    end

    context "when the registered_vessel_required? policy returns false" do
      let(:registered_vessel_required_policy) { false }

      it { expect(submission).to be_valid }
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
      let!(:submission) { create(:incomplete_submission) }
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

      it { submission.touch }
    end

    context "to assigned" do
      let!(:submission) { create(:unassigned_submission) }
      let!(:bob) { create(:user) }

      before { submission.claimed!(bob) }

      it { expect(submission.claimant).to eq(bob) }
    end

    context "from assigned to unassigned" do
      let!(:submission) { create(:assigned_submission) }
      let!(:bob) { create(:user) }

      before { submission.unclaimed! }

      it { expect(submission.claimant).to be_nil }
    end

    context "from assigned to referred" do
      let!(:submission) { create(:assigned_submission) }

      before { submission.referred! }

      it { expect(submission.claimant).to be_nil }
    end

    context "from referred to unassigned" do
      let!(:submission) { create(:referred_submission) }

      before do
        expect(Builders::ProcessingDatesBuilder)
          .to receive(:create)
          .with(submission)

        submission.unreferred!
      end

      it { expect(submission.claimant).to be_nil }
    end

    context "to printing" do
      let!(:submission) { create(:assigned_submission) }
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
      let!(:submission) { create(:printing_submission) }

      before do
        allow(Policies::Submission)
          .to receive(:printing_completed?)
          .with(submission)
      end

      it { submission.printed! }
    end
  end
end
