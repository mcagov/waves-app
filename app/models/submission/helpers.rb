module Submission::Helpers
  def notification_list
    (correspondences + notifications + declarations.map(&:notification)
    ).compact.sort { |a, b| b.created_at <=> a.created_at }
  end

  def process_application(registration_starts_at)
    registration_starts_at ||= Date.today

    Builders::NewRegistrationBuilder.create(
      self, registration_starts_at.to_datetime)

    update_attributes print_jobs: build_print_jobs
  end

  def editable?
    !completed? && !printing?
  end

  def update_print_job!(print_job_type)
    print_jobs[print_job_type] = Time.now
    update_attribute(:print_jobs, print_jobs)
    printed!
  end

  def build_print_jobs
    print_job_types.inject({}) do |h, print_job_type|
      h.merge(print_job_type => false)
    end
  end

  def print_jobs_completed?
    !print_jobs.map(&:last).include?(false)
  end

  def printed?(print_job_type)
    print_jobs[print_job_type.to_s].present?
  end

  def payment
    payments.first
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

  def build_ref_no
    self.ref_no = RefNo.generate(ref_no_prefix)
  end

  def ref_no_prefix
    "3N"
  end

  def print_job_types
    [:registration_certificate, :cover_letter]
  end

  def build_declarations
    Builders::DeclarationBuilder.create(
      self,
      user_input[:owners],
      user_input[:declarations]
    )
  end

  def remove_claimant
    update_attribute(:claimant, nil)
  end

  def add_claimant(user)
    update_attribute(:claimant, user)
  end

  def init_processing_dates
    update_attribute(:received_at, Date.today)

    if payment.amount == 7500
      update_attribute(:target_date, 5.days.from_now)
      update_attribute(:is_urgent, true)
    else
      update_attribute(:target_date, 20.days.from_now)
    end

    update_attribute(:referred_until, nil)
  end
end
