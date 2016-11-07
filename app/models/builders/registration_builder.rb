class Builders::RegistrationBuilder
  class << self
    def create(submission, registration_starts_at)
      @submission = submission
      @registration_starts_at = registration_starts_at
      @vessel = @submission.registered_vessel

      Registration.transaction do
        create_registration
        create_print_jobs
      end
    end

    private

    def create_registration
      registration_date = RegistrationDate.new(@registration_starts_at)

      @registration = Registration.create(
        vessel: @vessel,
        submission_id: @submission.id,
        registered_at: registration_date.starts_at,
        registered_until: registration_date.ends_at,
        actioned_by: @submission.claimant
      )
    end

    def create_print_jobs
      build_print_jobs =
        [:registration_certificate, :cover_letter
          ].inject({}) do |h, print_job_type|
          h.merge(print_job_type => false)
        end
      @submission.update_attribute(:print_jobs, build_print_jobs)
    end
  end
end
