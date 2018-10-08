class Report::StaffPerformanceByTask < Report
  def title
    "Staff Performance by Task"
  end

  def sub_report
    :staff_performance_by_person
  end

  def filter_fields
    [:filter_part, :filter_service, :filter_date_range]
  end

  def headings
    [
      :staff_member, :total_transactions,
      :within_service_standard, :service_standard_missed
    ]
  end

  def date_range_label
    "Task Actioned"
  end

  def user_label
    "Member of Staff"
  end

  def results
    users_results + totals
  end

  def users_results
    users.map do |user|
      staff_performance_logs = staff_performance_for(user)
      Result.new(
        [user.to_s,
         staff_performance_logs.count,
         staff_performance_logs.within_standard.count,
         RenderAsRed.new(staff_performance_logs.standard_missed.count)],
        user_id: user.id)
    end
  end

  def totals
    [Result.new(
      ["TOTAL",
       staff_performance_summary.count,
       staff_performance_summary.within_standard.count,
       RenderAsRed.new(staff_performance_summary.standard_missed.count)])]
  end

  def users
    User
      .order(:name)
      .includes(:staff_performance_logs)
      .all
  end

  def staff_performance_for(user)
    user
      .staff_performance_logs
      .in_part(@part)
      .created_after(@date_start)
      .created_before(@date_end)
      .includes(task: [:service])
      .for_service(@service_id)
      .all
  end

  def staff_performance_summary
    StaffPerformanceLog
      .for_service(@service_id)
      .in_part(@part)
      .created_after(@date_start)
      .created_before(@date_end)
  end
end
