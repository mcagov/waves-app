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
        submission_ids = Submission.where(task: task_type).completed.pluck(:id)

        [
          Task.new(task_type[1]).description,
          submission_ids.length,
          top_performer(submission_ids),
        ]
      end
    end

    def top_performer(submission_ids)
      result = Submission.select("claimant_id, count(*) AS total")
                         .includes(:claimant)
                         .where(id: submission_ids)
                         .group(:claimant_id)
                         .order("total desc")
                         .first

      return "-" if result.blank? || result.claimant.blank?
      "#{result.claimant} (#{result.total})"
    end
  end
end
