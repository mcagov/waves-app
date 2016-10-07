class Submission::NewRegistration < Submission
  def job_type
    "New Registration"
  end

  def process_application
    Builders::NewRegistrationBuilder.create(self)
    update_attributes print_jobs: build_print_jobs
  end

  def similar_vessels
    Search.similar_vessels(vessel)
  end

  def registration_certificate_printed?
    print_jobs["registration_certificate"]
  end

  def cover_letter_printed?
    print_jobs["cover_letter"]
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

  def build_print_jobs
    { registration_certificate: false, cover_letter: false }
  end
end
