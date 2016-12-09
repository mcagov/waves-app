class Builders::AssignedSubmissionBuilder
  class << self
    def create(task, part, registered_vessel, claimant)
      @task = task
      @part = part
      @registered_vessel = registered_vessel
      @claimant = claimant

      create_completed_submission
    end

    def current_state
      :assigned
    end

    private

    def create_completed_submission
      Submission.create(
        task: @task, part: @part,
        vessel_reg_no: @registered_vessel.reg_no,
        source: :manual_entry, state: current_state,
        ref_no: RefNo.generate_for(Submission.new),
        claimant: @claimant, received_at: Time.now,
        registry_info: @registered_vessel.registry_info,
        changeset: @registered_vessel.registry_info)
    end
  end
end
