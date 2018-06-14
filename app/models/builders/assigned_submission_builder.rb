class Builders::AssignedSubmissionBuilder
  class << self
    def create(task, part, registered_vessel, claimant)
      @task = task
      @part = part
      @registered_vessel = registered_vessel
      @claimant = claimant

      perform

      @submission
    end

    def current_state
      :assigned
    end

    private

    def perform
      @submission = Submission.create(
        task: @task, part: @registered_vessel.part,
        vessel_reg_no: @registered_vessel.reg_no,
        source: :manual_entry, state: current_state,
        ref_no: RefNo.generate_for(Submission.new),
        claimant: @claimant, received_at: Time.zone.now,
        changeset: @registered_vessel.registry_info)

      @submission = Builders::SubmissionBuilder.build_defaults(@submission)
      @submission.save!
    end
  end
end
