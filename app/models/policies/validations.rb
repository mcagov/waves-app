class Policies::Validations
  def initialize(task)
    @task = task
  end

  def errors
    return [] unless rules_policy.validates_on_approval
    [:correspondent_is_required]
  end

  private

  def rules_policy
    @rules_policy ||= Policies::Rules.new(@task)
  end
end
