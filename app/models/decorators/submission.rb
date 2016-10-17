class Decorators::Submission < SimpleDelegator
  def initialize(submission)
    @submission = submission
    super
  end

  def editable?
    !completed? && !printing?
  end

  def similar_vessels
    Search.similar_vessels(vessel)
  end

  def notification_list
    (correspondences + notifications + declarations.map(&:notification)
    ).compact.sort { |a, b| b.created_at <=> a.created_at }
  end

  def printed?(print_job_type)
    print_jobs && print_jobs[print_job_type.to_s].present?
  end
end
