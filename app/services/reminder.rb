class Reminder
  class << self
    def process_renewals
      Register::Vessel
        .joins(:current_registration)
        .where("registrations.registered_until < ?", 91.days.from_now)
        .each do |vessel|
          Notification::RenewalReminder.create(
            notifiable: vessel,
            recipient_email: "correspondent@example.com",
            recipient_name: "CORRESPONDENT")
        end
    end
  end
end
