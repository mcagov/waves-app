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
          current_registration_id:
            registered_vessel.registrations.first.try(:id))
    end
  end

  task close_terminated_vessels: :environment do
    Register::Vessel.termination_notice_issued.each do |vessel|
      section_notice = vessel.section_notices.last

      next unless section_notice
      next if section_notice.updated_at > 7.days.ago

      vessel.update_attribute(:frozen_at, nil)
      vessel.restore_active_state!

      submission =
        Builders::CompletedSubmissionBuilder.create(
          :termination_notice,
          vessel.part,
          vessel,
          section_notice.actioned_by)

      Builders::ClosedRegistrationBuilder
        .create(submission, Time.now, Task.new(:termination_notice).description)
    end
  end
end
