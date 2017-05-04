class Report::StaffPerformanceByTask < Report
  def title
    "Staff Performance by Task"
  end

  def filter_fields
    [:filter_task, :filter_part, :filter_date_range]
  end

  def columns
    [:staff_member, :online_applications, :paper_applications]
  end

  def results
    [Result.new([], {})]
  end
end
