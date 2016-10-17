module Submission::Helpers
  def notification_list
    (correspondences + notifications + declarations.map(&:notification)
    ).compact.sort { |a, b| b.created_at <=> a.created_at }
  end

  def update_print_job!(print_job_type)
    print_jobs[print_job_type] = Time.now
    update_attribute(:print_jobs, print_jobs)
    printed!
  end

  def print_jobs_completed?
    !print_jobs.map(&:last).include?(false)
  end

  def printed?(print_job_type)
    print_jobs && print_jobs[print_job_type.to_s].present?
  end

  def payment
    payments.first
  end

  protected

  def remove_claimant
    update_attribute(:claimant, nil)
  end

  def add_claimant(user)
    update_attribute(:claimant, user)
  end
end
