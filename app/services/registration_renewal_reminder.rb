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
          Time.zone.today, 90.days.from_now)
    end

    def build_reminders
      @registered_vessels.each do |registered_vessel|
        new(registered_vessel).process_reminder!(true)
      end
    end
  end

  def initialize(registered_vessel)
    @registered_vessel = registered_vessel
  end

  def process_reminder!(attempt_email_delivery = false)
    email_delivery = false
    email_delivery = deliver_email_notification if attempt_email_delivery
    build_renewal_reminder_letter_print_job unless email_delivery

    build_mortgagee_reminder_letter_print_jobs

    @registered_vessel
      .current_registration
      .update_attribute(:renewal_reminder_at, Time.zone.now)
  end

  private

  def deliver_email_notification
    notification =
      Notification::RenewalReminder.create(
        notifiable: @registered_vessel,
        recipient_name: @registered_vessel.correspondent.name,
        recipient_email: @registered_vessel.correspondent.email,
        attachments: [:renewal_reminder_letter])

    notification.deliverable?
  end

  def build_renewal_reminder_letter_print_job
    PrintJob.create(
      printable: @registered_vessel.current_registration,
      part: @registered_vessel.part,
      template: :renewal_reminder_letter)
  end

  def build_mortgagee_reminder_letter_print_jobs
    @registered_vessel.mortgagees.each do |mortgagee|
      PrintJob.create(
        printable: mortgagee,
        part: @registered_vessel.part,
        template: :mortgagee_reminder_letter)
    end
  end
end
