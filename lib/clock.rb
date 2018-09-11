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
  end
end
