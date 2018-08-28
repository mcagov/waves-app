class Policies::Activities
  def initialize(task)
    @task = task
  end

  def activities
    @task.service.activities.map(&:to_sym)
  end

  def supports_registration_date_inputs
    (activities &
      [
        :generate_new_5_year_registration,
        :generate_provisional_registration,
        :restore_closure,
      ]
    ).any?
  end

  def method_missing(method_name, *args)
    if @task.is_a?(Submission::Task)
      activities.include?(method_name)
    else
      super
    end
  end

  def respond_to_missing?(_method_name)
    false
  end
end
