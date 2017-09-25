class SafetyCertificateReminder
  class << self
    def process
      load_remindable_vessels
      build_notifications
    end

    private

    def load_remindable_vessels
      @registered_vessels =
        Register::Vessel
        .joins(:fishing_vessel_safety_certificates)
        .where("notes.expires_at < ?", 61.days.from_now)
        .includes(:safety_certificate_reminder)
        .where(notifications: { id: nil })
    end

    def build_notifications
      @registered_vessels.each do |registered_vessel|
        Notification::SafetyCertificateReminder.create(
          notifiable: registered_vessel,
          recipient_name: registered_vessel.correspondent.name,
          recipient_email: registered_vessel.correspondent.email)
      end
    end
  end
end
