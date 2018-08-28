class Builders::RestoreClosureBuilder
  class << self
    def create(task, registered_at, registered_until)
      @task = task
      @submission = @task.submission
      @registered_at = registered_at
      @registered_until = registered_until

      @registered_vessel = @submission.registered_vessel
      @previous_registration = @registered_vessel.current_registration

      create_restored_registration
    end

    private

    def create_restored_registration
      registration = Registration.create(
        vessel_id: @registered_vessel.id,
        registered_at: @registered_at,
        registered_until: @registered_until,
        registry_info: @registered_vessel.registry_info,
        actioned_by: @task.claimant)

      @submission.update_attributes(registration: registration)
      @registered_vessel.update_attributes(current_registration: registration)

      registration
    end
  end
end
