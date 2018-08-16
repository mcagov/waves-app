require "rails_helper"

describe Submission::Task do
  context "#ref_no" do
    let!(:task) { create(:task) }

    subject { task.ref_no }

    context "when the task has been confirmed" do
      before { task.confirm! }

      it { expect(subject).to eq("#{task.submission.ref_no}/1") }
    end

    context "when the task has not been confirmed" do
      it { expect(subject).to be_blank }
    end
  end

  context "#claimed_by?" do
    context "with a claimed task" do
      let(:task) { create(:claimed_task) }

      it "is claimed by the user" do
        expect(task.claimed_by?(task.claimant)).to be_truthy
      end

      it "is claimed by another user" do
        expect(task.claimed_by?(create(:user))).to be_falsey
      end

      context "that has been completed" do
        it do
          task.complete!
          expect(task.claimed_by?(task.claimant)).to be_falsey
        end
      end
    end

    context "with an unclaimed_task" do
      let(:task) { create(:task) }

      it { expect(task.claimed_by?(:foo)).to be_falsey }
    end
  end

  context "#start_date" do
    let(:submission) { create(:submission, received_at: "21/07/2016") }
    let(:task) { create(:task, submission: submission) }
    subject { task.start_date }

    it { expect(subject).to eq("21/07/2016".to_date) }
  end

  context "#reset_dates" do
    before do
      Timecop.travel(Time.new(2016, 6, 18))

      task.reset_dates
    end

    after { Timecop.return }

    let!(:task) do
      create(:unclaimed_task,
             start_date: "2011-12-12",
             target_date: "2011-12-29")
    end

    it "resets the start date" do
      expect(task.start_date).to eq(Date.new(2016, 6, 18))
    end

    it "resets the target_date" do
      expect(task.target_date).to eq(Date.new(2016, 7, 4))
    end
  end

  describe "service_level_validations validations" do
    let(:task) do
      build(
        :task,
        service_level: service_level,
        service: create(:standard_only_service))
    end
    before { task.valid? }

    context "is required" do
      let(:service_level) { nil }
      it { expect(task.errors).to include(:service_level) }
    end

    context "is an allowed type" do
      let(:service_level) { :standard }
      it { expect(task.errors).not_to include(:service_level) }
    end

    context "is a disallowed type" do
      let(:service_level) { :premium }
      it { expect(task.errors).to include(:service_level) }
    end
  end

  context "#target_date" do
    let(:task) { create(:task) }
    subject { task.target_date }

    it "is initialised as blank" do
      expect(subject).to be_blank
    end

    context "#confirm" do
      before do
        expect(TargetDate)
          .to receive(:for_task).with(task).and_return("13/11/2012")

        task.confirm!
      end

      it { expect(task.target_date).to eq("13/11/2012".to_date) }
    end
  end

  describe "state machine events" do
    let(:task) { create(:task) }
    let(:user) { create(:user) }

    context "#confirm!" do
      before do
        expect(task).to receive(:set_submission_ref_counter)
        expect(task).to receive(:set_defaults)
      end

      it { task.confirm! }
    end

    context "#claim!" do
      before do
        task.confirm!
        task.claim!(user)
      end

      it { expect(task.claimant).to eq(user) }
    end

    context "#refer!" do
      before do
        task.confirm!
        task.claim!(user)
        task.refer!
      end

      it { expect(task.claimant).to be_nil }
    end

    context "#unclaim!" do
      before do
        task.confirm!
        task.claim!(user)
        task.unclaim!
      end

      it { expect(task.claimant).to be_nil }
    end

    context "#complete!" do
      before do
        task.confirm!
        task.claim!(user)
        task.complete!
      end

      it { expect(task).to be_completed }
    end

    context "#cancel!" do
      before do
        task.confirm!
        task.claim!(user)
        task.cancel!
      end

      it { expect(task).to be_cancelled }
    end

    context "#claim_referral!" do
      before do
        expect(task).to receive(:reset_dates)

        task.confirm!
        task.claim!(user)
        task.refer!
        task.claim_referral!(user)
      end

      it { expect(task).to be_claimed }
      it { expect(task.claimant).to eq(user) }
    end

    context "#unrefer!" do
      before do
        expect(task).to receive(:reset_dates)

        task.confirm!
        task.claim!(user)
        task.refer!
        task.unrefer!
      end

      it { expect(task).to be_unclaimed }
    end
  end

  context "scopes" do
    let!(:initialising) { create(:task) }
    let!(:unclaimed) { create(:unclaimed_task) }
    let!(:claimed) { create(:claimed_task) }
    let!(:referred) { create(:referred_task) }
    let!(:cancelled) { create(:cancelled_task) }
    let!(:completed) { create(:completed_task) }

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
