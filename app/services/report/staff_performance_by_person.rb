class Report::StaffPerformanceByPerson < Report
  def title
    "Performance by Member of Staff"
  end

  def filter_fields
    [:filter_part, :filter_user, :filter_service, :filter_date_range]
  end

  def headings
    [
      :task_type, :application, :activity, :service_level,
      :part, :date_received, :target_date, :date_actioned
    ]
  end

  def date_range_label
    "Task Actioned"
  end

  def user_label
    "Member of Staff"
  end

  def results
    logs.map do |log|
      task = log.task
      Result.new(
        [task.service,
         RenderAsLinkToSubmission.new(task.submission),
         log.activity.to_s.humanize,
         log.service_level.to_s.humanize, log.part.to_s.humanize,
         task.submission.received_at, log.target_date, log.created_at])
    end
  end

  def logs
    StaffPerformanceLog
      .actioned_by(@user_id)
      .in_part(@part)
      .created_after(@date_start)
      .created_before(@date_end)
      .for_service(@service_id)
      .includes(task: [:submission, :service])
      .all
  end
end
