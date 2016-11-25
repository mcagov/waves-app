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

      Registration.create(
        vessel_id: @registered_vessel.id,
        registered_at: registration_date.starts_at,
        registered_until: registration_date.ends_at,
        submission_ref_no: @submission.ref_no,
        registry_info: @registered_vessel.registry_info,
        actioned_by: @submission.claimant
      )
    end
  end
end
