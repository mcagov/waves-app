class Builders::RegistrationBuilder
  class << self
    def create(task, registered_vessel, starts_at, ends_at, provisional)
      registration = Registration.create(
        vessel_id: registered_vessel.id,
        registered_at: starts_at,
        registered_until: ends_at,
        registry_info: registered_vessel.registry_info,
        actioned_by: task.claimant,
        provisional: provisional)

      task.submission.update_attributes(registration: registration)

      registration
    end
  end
end
