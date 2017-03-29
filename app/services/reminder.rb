class Reminder
  class << self
    def process_all
      process_renewals
      process_expirations
      process_terminations
    end

    def process_renewals
      renewable_vessel_scope
        .each do |vessel|
          Notification::RenewalReminder.create(
            notifiable: vessel,
            recipient_email: vessel.correspondent.email,
            recipient_name: vessel.correspondent.name)

          vessel.current_registration
                .update_attribute(:renewal_reminder_at, Time.now)
        end
    end

    def process_expirations
      expirable_vessel_scope
        .each do |vessel|
          Notification::ExpirationReminder.create(
            notifiable: vessel,
            recipient_email: vessel.correspondent.email,
            recipient_name: vessel.correspondent.name)

          vessel.current_registration
                .update_attribute(:expiration_reminder_at, Time.now)
        end
    end

    def process_terminations
      terminatable_vessel_scope
        .each do |vessel|
          PrintJob.create(
            printable: vessel,
            part: vessel.part,
            template: :termination)

          vessel.current_registration
                .update_attribute(:termination_at, Time.now)
        end
    end

    private

    def vessel_scope
      Register::Vessel
        .joins(:current_registration)
    end

    def renewable_vessel_scope
      vessel_scope
        .where("registrations.renewal_reminder_at IS NULL")
        .where("registrations.registered_until < ?", 91.days.from_now)
    end

    def expirable_vessel_scope
      vessel_scope
        .where("registrations.expiration_reminder_at IS NULL")
        .where("registrations.registered_until < ?", Time.now)
    end

    def terminatable_vessel_scope
      vessel_scope
        .where("registrations.termination_at IS NULL")
        .where("registrations.registered_until < ?", 29.days.ago)
    end
  end
end
