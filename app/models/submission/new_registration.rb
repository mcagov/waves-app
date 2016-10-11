class Submission::NewRegistration < Submission
  def job_type
    "New Registration"
  end

  def process_application(registration_starts_at = Time.now)
    Builders::NewRegistrationBuilder.create(
      self, registration_starts_at.to_datetime)

    update_attributes print_jobs: build_print_jobs
  end

  def similar_vessels
    Search.similar_vessels(vessel)
  end

  protected

  def unassignable?
    declarations.incomplete.empty? && payment.present?
  end

  def init_new_submission
    build_ref_no
    build_declarations
  end

  def ref_no_prefix
    "3N"
  end

  def print_job_types
    [:registration_certificate, :cover_letter]
  end
end
