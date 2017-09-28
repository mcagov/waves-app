class RegistrationRenewalReminder
  class << self
    def process
      load_remindable_vessels
      build_reminders
    end

    private

    def load_remindable_vessels
      @registered_vessels =
        Register::Vessel
        .joins(:current_registration)
        .where("registrations.renewal_reminder_at IS NULL")
        .where(
          "registrations.registered_until between ? AND ?",
          Date.today, 90.days.from_now)
    end

    def build_reminders
      @registered_vessels.each do |registered_vessel|
        build_email_notification(registered_vessel)

        registered_vessel
          .current_registration
          .update_attribute(:renewal_reminder_at, Time.now)
      end
    end

    def build_email_notification(registered_vessel)
      Notification::RenewalReminder.create(
        notifiable: registered_vessel,
        recipient_name: registered_vessel.correspondent.name,
        recipient_email: registered_vessel.correspondent.email)
    end
  end
end
