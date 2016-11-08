class Submission::ApplicationProcessor
  class << self
    def run(submission, registration_starts_at)
      @submission = submission
      @task = Task.new(@submission.task)

      Builders::RegistryBuilder.create(@submission) if @task.builds_registry?

      if @task.prints_certificate?
        Builders::RegistrationBuilder
          .create(@submission, registration_starts_at)
      end
    end
  end
end
