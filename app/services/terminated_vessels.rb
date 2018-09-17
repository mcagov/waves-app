class TerminatedVessels
  class << self
    def close!
      closeable_vessels.each do |vessel|
        vessel.restore_active_state!
        create_closed_registration(vessel)
        Note.create(noteable: @vessel, content: termination_message)
      end
    end

    private

    def closeable_vessels
      Register::Vessel
        .termination_notice_issued
        .where("termination_notice_issued_at < ?", 7.days.ago)
    end

    def termination_message
      "Termination Notice invoked by Daily Job"
    end

    def create_closed_registration(vessel)
      previous_registration = vessel.current_registration
      registration = Registration.create(
        vessel_id: vessel.id,
        registered_at: previous_registration.try(:registered_at),
        registered_until: previous_registration.try(:registered_until),
        closed_at: Time.zone.now,
        description: termination_message,
        registry_info: vessel.registry_info)

      vessel.update_attributes(current_registration: registration)
    end
  end
end
