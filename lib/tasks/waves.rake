namespace :waves do
  task unclaim_claimed_tasks: :environment do
    Submission::Task.claimed.map(&:unclaim!)
  end

  task expire_referrals: :environment do
    Submission::Task
      .referred
      .where("referred_until < ?", Time.zone.today.at_end_of_day)
      .each(&:unrefer!)
  end

  task process_reminders: :environment do
    CarvingAndMarkingReminder.process
    CodeCertificateReminder.process
    RegistrationRenewalReminder.process
    SafetyCertificateReminder.process
  end

  task close_terminated_vessels: :environment do
    TerminatedVessels.close!
  end

  task clean_up_sessions: :environment do
    ActiveRecord::SessionStore::Session
      .where("updated_at < ?", 30.days.ago)
      .delete_all
  end
end
