require "clockwork"
require "./config/boot"
require "./config/environment"

include Clockwork

every 1.day, "daily_jobs", at: "04:00" do
  DailyJob.all
end

class DailyJob
  class << self
    def all
      unclaim_claimed_submissions
      expire_referrals
      process_reminders
      close_terminated_vessels
      clean_up_sessions
    end

    private

    def unclaim_claimed_submissions
      Submission::Task.claimed.map(&:unclaim!)
    end

    def expire_referrals
      Submission::Task
        .referred
        .where("referred_until < ?", Time.zone.today.at_end_of_day)
        .each(&:unrefer!)
    end

    def process_reminders
      CarvingAndMarkingReminder.process
      CodeCertificateReminder.process
      RegistrationRenewalReminder.process
      SafetyCertificateReminder.process
    end

    def close_terminated_vessels
      TerminatedVessels.close!
    end

    def clean_up_sessions
      ActiveRecord::SessionStore::Session
        .where("updated_at < ?", 30.days.ago)
        .delete_all
    end
  end
end
