class Submission::ApplicationProcessor
  class << self
    def run(submission, approval_params = {})
      @submission = submission
      @task = Task.new(@submission.task)
      @approval_params = approval_params

      Builders::RegistryBuilder.create(@submission) if @task.builds_registry?

      if @task.prints_certificate?
        Builders::RegistrationBuilder
          .create(@submission, @approval_params[:registration_starts_at])
      end
    end
  end
end
