class Submission::ApplicationProcessor
  class << self
    def run(submission, approval_params = {})
      @submission = submission
      @task = Task.new(@submission.task)
      @approval_params = approval_params

      @registered_vessel = build_registry if @task.builds_registry?
      @registration = build_registration if @task.builds_registration?

      build_closed_registration if @task == :closure

      add_certificates_to_print_queue if @task.prints_certificate?
    end

    private

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
        .create(@submission,
                @approval_params[:closure_at],
                @approval_params[:closure_reason])
    end

    def add_certificates_to_print_queue
      [:registration_certificate, :cover_letter]
    end
  end
end
