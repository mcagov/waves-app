class Report
  class << self
    def build(template, filters)
      case template.to_sym
      when :staff_performance
        Report::StaffPerformance.new(filters)
      end
    end
  end
end
