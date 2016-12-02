class Builders::RestoreClosedRegistrationBuilder
  class << self
    def create(submission)
      @submission = submission
      @registered_vessel = @submission.registered_vessel
      @previous_registration = @registered_vessel.current_registration

      create_closed_registration
    end

    private

    def create_closed_registration
      Registration.create(
        vessel_id: @registered_vessel.id,
        registered_at: @previous_registration.try(:registered_at),
        registered_until: @previous_registration.try(:registered_until),
        submission_ref_no: @submission.ref_no,
        task: @submission.task,
        registry_info: @registered_vessel.registry_info,
        actioned_by: @submission.claimant)
    end
  end
end
