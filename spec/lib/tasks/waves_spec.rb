require "rails_helper"
require "rake"

describe "Waves" do
  before(:all) do
    load File.expand_path("lib/tasks/waves.rake")
    Rake::Task.define_task(:environment)
  end

  context "expire_referrals" do
    before do
      create(:expired_referred_submission)
      create(:referred_submission)
      Rake::Task["waves:expire_referrals"].invoke
    end

    it "resets one of the submissions" do
      expect(Submission.referred.length).to eq(1)
      expect(Submission.unassigned.length).to eq(1)
    end
  end
end
