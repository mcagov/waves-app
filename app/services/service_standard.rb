class ServiceStandard
  class << self
    def status(task)
      days_away = TargetDate.days_away(task.target_date)

      return :green if days_away > 2
      return :amber if days_away > -1
      :red
    end
  end
end
