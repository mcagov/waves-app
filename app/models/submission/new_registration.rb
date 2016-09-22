class Submission::NewRegistration < Submission
  def job_type
    "New Registration"
  end

  def process_application
    Builders::RegistrationBuilder.create(self)
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
end
