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
    submission.carving_and_markings.empty?
  end

  def carving_marking_not_received?
    submission.carving_and_marking_received_at.blank?
  end

  def rules_policy
    @rules_policy ||= Policies::Rules.new(@task)
  end
end
