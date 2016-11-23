class Builders::ClosedRegistrationBuilder
  class << self
    def create(submission, closure_at, closure_reason)
      @submission = submission
      @closure_at = closure_at
      @closure_reason = closure_reason

      Registration.transaction do
        close_registration
        create_print_jobs
      end
    end

    private

    def close_registration
    end

    def create_print_jobs
    end
  end
end
