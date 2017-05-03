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

    def columns
      [:task_type, :total_transactions, :top_performer]
    end

    def rows
      Task.all_task_types.map do |task_type|
        [
          Task.new(task_type[1]).description, "A", "B"
        ]
      end
    end
  end
end
