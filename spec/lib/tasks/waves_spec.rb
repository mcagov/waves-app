require "rails_helper"
require "rake"

describe "Waves" do
  before(:all) do
    DatabaseCleaner.clean
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

  xcontext "close_terminated_vessels" do
    let!(:vessel_1) { create(:registered_vessel) }
    let!(:vessel_2) { create(:registered_vessel) }
    let!(:vessel_3) { create(:registered_vessel) }

    before do
      init_closeable_vessel(vessel_2)
      init_non_closeable_vessel(vessel_3)

      Rake::Task["waves:close_terminated_vessels"].invoke
    end

    it "leaves vessel_1 as registered " do
      expect(vessel_1.reload.registration_status).to eq(:registered)
    end

    it "closes the registration for vessel_2" do
      expect(vessel_2.reload.registration_status).to eq(:closed)
      expect(vessel_2.reload.frozen_at).to be_nil
      expect(vessel_2.reload.current_state).to eq(:active)
    end

    it "leaves vessel_3 as termination_notice_issued" do
      expect(vessel_3.reload.current_state).to eq(:termination_notice_issued)
    end
  end
end

def init_closeable_vessel(vessel)
  vessel.update_column(:frozen_at, Time.now)
  section_notice = Register::SectionNotice.create(noteable: vessel)
  vessel.issue_section_notice!
  vessel.issue_termination_notice!
  section_notice.update_column(:updated_at, 8.days.ago)
end

def init_non_closeable_vessel(vessel)
  vessel.update_column(:frozen_at, Time.now)
  section_notice = Register::SectionNotice.create(noteable: vessel)
  vessel.issue_section_notice!
  vessel.issue_termination_notice!
  section_notice.update_column(:updated_at, 6.days.ago)
end
