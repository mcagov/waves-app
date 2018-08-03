require "rails_helper"

describe Submission::Task do
  context "#ref_no" do
    let!(:submission_task) { create(:submission_task) }

    subject { submission_task.ref_no }

    context "when the task has been confirmed" do
      before { submission_task.confirm! }

      it { expect(subject).to eq("#{submission_task.submission.ref_no}/1") }
    end

    context "when the task has not been confirmed" do
      it { expect(subject).to be_blank }
    end
  end

  context "#start_date" do
    let(:submission) { create(:submission, received_at: "21/07/2016") }
    let(:submission_task) { create(:submission_task, submission: submission) }
    subject { submission_task.start_date }

    it { expect(subject).to eq("21/07/2016".to_date) }
  end

  context "#reset_dates" do
    before do
      Timecop.travel(Time.new(2016, 6, 18))

      submission_task.reset_dates
    end

    after { Timecop.return }

    let!(:submission_task) do
      create(:unclaimed_task,
             start_date: "2011-12-12",
             target_date: "2011-12-29")
    end

    it "resets the start date" do
      expect(submission_task.start_date).to eq(Date.new(2016, 6, 18))
    end

    it "resets the target_date" do
      expect(submission_task.target_date).to eq(Date.new(2016, 7, 4))
    end
  end

  describe "service_level_validations validations" do
    let(:submission_task) do
      build(
        :submission_task,
        service_level: service_level,
        service: create(:standard_only_service))
    end
    before { submission_task.valid? }

    context "is required" do
      let(:service_level) { nil }
      it { expect(submission_task.errors).to include(:service_level) }
    end

    context "is an allowed type" do
      let(:service_level) { :standard }
      it { expect(submission_task.errors).not_to include(:service_level) }
    end

    context "is a disallowed type" do
      let(:service_level) { :premium }
      it { expect(submission_task.errors).to include(:service_level) }
    end
  end

  context "#target_date" do
    let(:submission_task) { create(:submission_task) }
    subject { submission_task.target_date }

    it "is initialised as blank" do
      expect(subject).to be_blank
    end

    context "#confirm" do
      before do
        expect(TargetDate)
          .to receive(:for_task).with(submission_task).and_return("13/11/2012")

        submission_task.confirm!
      end

      it { expect(submission_task.target_date).to eq("13/11/2012".to_date) }
    end
  end

  describe "state machine events" do
    let(:submission_task) { create(:submission_task) }
    let(:user) { create(:user) }

    context "#confirm!" do
      before do
        expect(submission_task).to receive(:set_submission_ref_counter)
        expect(submission_task).to receive(:set_defaults)
      end

      it { submission_task.confirm! }
    end

    context "#claim!" do
      before do
        submission_task.confirm!
        submission_task.claim!(user)
      end

      it { expect(submission_task.claimant).to eq(user) }
    end

    context "#refer!" do
      before do
        submission_task.confirm!
        submission_task.claim!(user)
        submission_task.refer!
      end

      it { expect(submission_task.claimant).to be_nil }
    end

    context "#unclaim!" do
      before do
        submission_task.confirm!
        submission_task.claim!(user)
        submission_task.unclaim!
      end

      it { expect(submission_task.claimant).to be_nil }
    end

    context "#complete!" do
      before do
        submission_task.confirm!
        submission_task.claim!(user)
        submission_task.complete!
      end

      it { expect(submission_task).to be_completed }
    end

    context "#cancel!" do
      before do
        submission_task.confirm!
        submission_task.claim!(user)
        submission_task.cancel!
      end

      it { expect(submission_task).to be_cancelled }
    end

    context "#claim_referral!" do
      before do
        expect(submission_task).to receive(:reset_dates)

        submission_task.confirm!
        submission_task.claim!(user)
        submission_task.refer!
        submission_task.claim_referral!(user)
      end

      it { expect(submission_task).to be_claimed }
      it { expect(submission_task.claimant).to eq(user) }
    end

    context "#unrefer!" do
      before do
        expect(submission_task).to receive(:reset_dates)

        submission_task.confirm!
        submission_task.claim!(user)
        submission_task.refer!
        submission_task.unrefer!
      end

      it { expect(submission_task).to be_unclaimed }
    end
  end

  context "scopes" do
    let!(:initialising) { create(:submission_task) }
    let!(:unclaimed) { create(:unclaimed_task) }
    let!(:claimed) { create(:claimed_task) }
    let!(:referred) { create(:referred_task) }
    let!(:cancelled) { create(:cancelled_task) }
    let!(:completed) { create(:completed_submission_task) }

    it "confirmed" do
      expect(described_class.confirmed).to match(
        [unclaimed, claimed, referred, cancelled, completed])
    end

    it "active" do
      expect(described_class.active).to match(
        [unclaimed, claimed, referred])
    end
  end
end
