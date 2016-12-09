class Submission::ApplicationProcessor
  class << self
    def run(submission, approval_params = {})
      @submission = submission
      @task = Task.new(@submission.task)
      @approval_params = approval_params

      process_changes
      build_print_jobs
    end

    private

    def process_changes
      @registered_vessel = build_registry if @task.builds_registry?

      @registration =
        if @task.builds_registration?
          build_registration
        elsif @task == :closure
          build_closed_registration
        else
          clone_current_registration
        end
    end

    def build_registry
      Builders::RegistryBuilder.create(@submission)
    end

    def build_registration
      Builders::RegistrationBuilder
        .create(
          @submission,
          @registered_vessel, @approval_params[:registration_starts_at])
    end

    def build_closed_registration
      Builders::ClosedRegistrationBuilder
        .create(
          @submission,
          @approval_params[:closure_at],
          @approval_params[:closure_reason])
    end

    def clone_current_registration
      Builders::ClonedRegistrationBuilder.create(@submission)
    end

    def build_print_jobs
      return unless @task.print_job_templates

      Builders::PrintJobBuilder
        .create(@registration, @submission.part, @task.print_job_templates)
    end
  end
end