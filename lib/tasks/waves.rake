namespace :waves do
  task expire_referrals: :environment do
    Submission.referred.referred_until_expired.each(&:unreferred!)
  end

  task process_reminders: :environment do
    CarvingAndMarkingReminder.process
    CodeCertificateReminder.process
    RegistrationRenewalReminder.process
    SafetyCertificateReminder.process
  end

  task unclaim_claimed_submissions: :environment do
    Submission.assigned.map(&:unclaimed!)
  end

  task assign_vessel_current_registration: :environment do
    Register::Vessel.all.each do |registered_vessel|
      registered_vessel
        .update_columns(
          current_registration_id: registered_vessel.registrations.first.try(:id))
    end
  end
end
