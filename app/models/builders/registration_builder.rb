class Builders::RegistrationBuilder
  class << self
    def create(submission, registered_vessel, registration_starts_at)
      @submission = submission
      @registered_vessel = registered_vessel
      @registration_starts_at = registration_starts_at || Date.today

      create_registration
    end

    private

    def create_registration
      registration_date = RegistrationDate.new(@registration_starts_at)

      registration = Registration.create(
        vessel_id: @registered_vessel.id,
        registered_at: registration_date.starts_at,
        registered_until: registration_date.ends_at,
        registry_info: @registered_vessel.registry_info,
        actioned_by: @submission.claimant)

      @submission.update_attributes(registration: registration)

      registration
    end
  end
end
