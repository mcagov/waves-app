class Report
  class << self
    def find(template)
      case template.to_sym
      when :staff_performance
        StaffPerformance.new
      end
    end
  end

  class StaffPerformance
    def title
      "Staff Performance"
    end
  end
end
