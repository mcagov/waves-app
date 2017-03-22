class Submission::ApplicationProcessor
  class << self
    def run(submission, approval_params = {})
      @submission = submission
      @task = Task.new(@submission.task)
      @approval_params = approval_params

      assign_registered_vessel
      assign_registration

      build_print_jobs
      build_csr_issue_number
    end

    private

    def assign_registered_vessel
      @registered_vessel =
        if @task.builds_registry?
          Builders::RegistryBuilder.create(@submission)
        else
          @submission.registered_vessel
        end
    end

    def assign_registration
      @registration =
        if @task.builds_registration?
          build_new_registration
        elsif @task == :closure
          build_closed_registration
        else
          build_cloned_registration
        end
    end

    def build_new_registration
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

    def build_cloned_registration
      Builders::ClonedRegistrationBuilder.create(@submission)
    end

    def build_print_jobs
      return unless @task.print_job_templates
      return if @submission.electronic_delivery?

      Builders::PrintJobBuilder
        .create(
          @submission,
          @submission.registration,
          @submission.part,
          @task.print_job_templates)
    end

    def build_csr_issue_number
      Builders::CsrIssueNumberBuilder.build(@submission) if @task.issues_csr?
    end
  end
end
