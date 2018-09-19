class Report::StaffPerformance < Report
  def title
    "Staff Performance"
  end

  def sub_report
    :staff_performance_by_task
  end

  def filter_fields
    [:filter_part, :filter_date_range]
  end

  def headings
    [
      :task_type, :total_transactions,
      :within_service_standard, :service_standard_missed
    ]
  end

  def date_range_label
    "Application Received"
  end

  def results
    Service.order(:name).includes(:staff_performance_logs).all.map do |service|
      data_elements =
        [
          service.to_s,
          service.staff_performance_logs.count,
          service.staff_performance_logs.within_standard.count,
          RenderAsRed.new(service.staff_performance_logs.standard_missed.count),
        ]

      Result.new(data_elements, service: service.id)
    end
  end
end
