class Submission::ApplicationProcessor
  class << self
    def run(submission, approval_params = {})
      @submission = submission
      @task = Task.new(@submission.task)
      @approval_params = approval_params

      build_registry if @task.builds_registry?
      build_registration if @task.prints_certificate?
      build_closed_registration if @task == :closure
    end

    private

    def build_registry
      Builders::RegistryBuilder.create(@submission)
    end

    def build_registration
      Builders::RegistrationBuilder
        .create(@submission, @approval_params[:registration_starts_at])
    end

    def build_closed_registration
      Builders::ClosedRegistrationBuilder
        .create(@submission,
                @approval_params[:closure_at],
                @approval_params[:closure_reason])
    end
  end
end
