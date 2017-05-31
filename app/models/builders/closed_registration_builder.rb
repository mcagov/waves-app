class Builders::ClosedRegistrationBuilder
  class << self
    def create(submission, closure_at, closure_reason, supporting_info = nil)
      @submission = submission
      @closure_at = closure_at
      @closure_reason = closure_reason
      @supporting_info = supporting_info

      @registered_vessel = @submission.registered_vessel
      @previous_registration = @registered_vessel.current_registration

      create_closed_registration
    end

    private

    def create_closed_registration
      registration = Registration.create(
        vessel_id: @registered_vessel.id,
        registered_at: @previous_registration.try(:registered_at),
        registered_until: @previous_registration.try(:registered_until),
        closed_at: @closure_at, description: @closure_reason,
        supporting_info: @supporting_info,
        registry_info: @registered_vessel.registry_info,
        actioned_by: @submission.claimant)

      @submission.update_attributes(registration: registration)

      registration
    end
  end
end
