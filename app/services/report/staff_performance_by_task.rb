class Report::StaffPerformanceByTask < Report
  def title
    "Staff Performance by Task"
  end

  def filter_fields
    [:filter_task, :filter_part, :filter_date_range]
  end
end
