namespace :waves do
  task expire_referrals: :environment do
    Submission.referred.referred_until_expired.each(&:unreferred!)
  end

  task process_reminders: :environment do
    CarvingAndMarkingReminder.process
    CodeCertificateReminder.process
    RegistrationReminder.process_all
    SafetyCertificateReminder.process
  end

  task unclaim_claimed_submissions: :environment do
    Submission.assigned.map(&:unclaimed!)
  end
end
