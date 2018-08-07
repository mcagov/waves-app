class Policies::Rules
  def initialize(task)
    @task = task
  end

  def rules
    @task.service.rules.map(&:to_sym)
  end

  class << self
    def method_missing(method_name, *args)
      if args[0].is_a?(Submission::Task)
        new(args[0]).rules.include?(method_name)
      else
        super
      end
    end

    def respond_to_missing?(_method_name)
      false
    end
  end
end
