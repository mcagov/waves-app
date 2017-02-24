class Builders::AssignedSubmissionBuilder
  class << self
    def create(task, part, registered_vessel, claimant)
      @task = task
      @part = part
      @registered_vessel = registered_vessel
      @claimant = claimant

      @submission = build_submission
      build_not_required_declarations

      Builders::SubmissionBuilder.build_defaults(@submission)
    end

    def current_state
      :assigned
    end

    private

    def build_submission
      Submission.create(
        task: @task, part: @part,
        vessel_reg_no: @registered_vessel.reg_no,
        source: :manual_entry, state: current_state,
        ref_no: RefNo.generate_for(Submission.new),
        claimant: @claimant, received_at: Time.now,
        registry_info: @registered_vessel.registry_info,
        changeset: @registered_vessel.registry_info)
    end

    def build_not_required_declarations
      @registered_vessel.owners.each do |owner|
        Declaration.create(
          submission: @submission,
          changeset: owner,
          state: :not_required)
      end
    end
  end
end
