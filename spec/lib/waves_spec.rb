require "rails_helper"
require "rake"

describe "Waves" do
  before(:all) do
    DatabaseCleaner.clean
    load File.expand_path("lib/tasks/waves.rake")
    Rake::Task.define_task(:environment)
  end

  context "unclaim_claimed_tasks" do
    before do
      create(:claimed_task)
      Rake::Task["waves:unclaim_claimed_tasks"].invoke
    end

    it do
      expect(Submission::Task.claimed.count).to eq(0)
      expect(Submission::Task.unclaimed.count).to eq(1)
    end
  end

  context "expire_referrals" do
    before do
      create(:referred_task)
      create(:referred_task, referred_until: 1.day.ago)
      Rake::Task["waves:expire_referrals"].invoke
    end

    it "resets one of the tasks" do
      expect(Submission::Task.referred.count).to eq(1)
      expect(Submission::Task.unclaimed.count).to eq(1)
    end
  end

  context "process_reminders" do
    before do
      expect(CarvingAndMarkingReminder).to receive(:process)
      expect(CodeCertificateReminder).to receive(:process)
      expect(RegistrationRenewalReminder).to receive(:process)
      expect(SafetyCertificateReminder).to receive(:process)
    end

    it { Rake::Task["waves:process_reminders"].invoke }
  end

  context "close_terminated_vessels" do
    before { expect(TerminatedVessels).to receive(:close!) }

    it { Rake::Task["waves:close_terminated_vessels"].invoke }
  end
end
