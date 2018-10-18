class Policies::Validations
  def initialize(task)
    @task = task
    @submission = @task.submission
  end

  # rubocop:disable all
  def errors
    list = []

    if rules_policy.validates_on_approval
      list << :vessel_required if submission.vessel.name.blank?
      list << :owners_required if submission.owners.empty?
      list << :vessel_frozen if registered_vessel_frozen?
      list << :shareholding_count if shareholding_incomplete?
      list << :correspondent_required if correspondent_missing?
      list << :hin_invalid if hin_invalid?
      list << :radio_call_sign_invalid if radio_call_sign_invalid?
      list << :year_of_build_invalid if year_of_build_invalid?
      list << :part_3_length_invalid if part_3_length_invalid?
    end

    if rules_policy.declarations_required
      list << :declarations_required if declarations_missing?
    end

    if rules_policy.carving_and_marking_required
      if carving_marking_not_issued?
        list << :carving_marking_not_issued
      elsif carving_marking_not_received?
        list << :carving_marking_not_received
      end
    end

    list
  end
  # rubocop:enable all

  private

  def submission
    @submission ||= @task.submission
  end

  def registered_vessel
    @registered_vessel ||= submission.registered_vessel
  end

  def registered_vessel_frozen?
    registered_vessel ? registered_vessel.frozen_at : false
  end

  def shareholding_incomplete?
    return false unless Policies::Workflow.uses_shareholding?(submission)
    ShareHolding.new(submission).status != :complete
  end

  def correspondent_missing?
    return false if Policies::Definitions.part_3?(submission)
    submission.correspondent.blank?
  end

  def declarations_missing?
    Policies::Declarations.new(submission).incomplete?
  end

  def carving_marking_not_issued?
    return false if Policies::Definitions.part_3?(submission)
    submission.carving_and_markings.empty?
  end

  def carving_marking_not_received?
    return false if Policies::Definitions.part_3?(submission)
    submission.carving_and_marking_received_at.blank? &&
      submission.carving_and_marking_receipt_skipped_at.blank?
  end

  def hin_invalid?
    if submission.vessel && submission.vessel.hin.present?
      !submission.vessel.hin.match(/\A(?:([A-Z]{2}\-)?)[0-9A-Z]{12}?\z/)
    end
  end

  def radio_call_sign_invalid?
    if submission.vessel && submission.vessel.radio_call_sign.present?
      !submission.vessel.radio_call_sign.match(/\A[0-9A-Z]{4,5}\z/)
    end
  end

  def year_of_build_invalid?
    if submission.vessel && submission.vessel.year_of_build.present?
      !submission.vessel.year_of_build.match(/\A(17|18|19|20)\d{2}\z/)
    end
  end

  def part_3_length_invalid?
    return false unless Policies::Definitions.part_3?(submission)
    length_in_meters = submission.vessel.try(:length_in_meters).to_f
    length_in_meters.zero? || (length_in_meters >= 24.0)
  end

  def rules_policy
    @rules_policy ||= Policies::Rules.new(@task)
  end
end
