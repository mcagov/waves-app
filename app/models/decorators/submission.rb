class Decorators::Submission < SimpleDelegator
  def initialize(submission)
    @submission = submission
    super
  end

  def similar_vessels
    Search.similar_vessels(vessel)
  end

  def notification_list
    Builders::NotificationListBuilder.for_submission(@submission)
  end

  def printed?(print_job_type)
    print_jobs && print_jobs[print_job_type.to_s].present?
  end

  def vessel_name
    return vessel.name if vessel.name
    if finance_payment && finance_payment.vessel_name.present?
      finance_payment.vessel_name
    else
      "Unkown"
    end
  end

  def applicant_name
    return correspondent if correspondent
    if finance_payment && finance_payment.applicant_name.present?
      finance_payment.applicant_name
    else
      "Unkown"
    end
  end

  def source_description
    source.titleize if source
  end

  private

  def finance_payment
    payment.remittance if source.to_sym == :manual_entry
  end
end
