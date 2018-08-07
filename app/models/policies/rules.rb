class Policies::Rules
  def initialize(task)
    @task = task
  end

  def rules
    @task.service.rules.map(&:to_sym)
  end

  class << self
    def issues_csr?(task)
      new(task).rules.include?(:issues_csr)
    end
  end
end
