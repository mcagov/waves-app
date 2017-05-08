class Report::StaffPerformanceByTask < Report
  def title
    "Staff Performance by Task"
  end

  def filter_fields
    [:filter_task, :filter_part, :filter_date_range]
  end

  def headings
    [:staff_member, :online_applications, :paper_applications, :total]
  end

  def results
    submissions.map do |submission|
      Result.new(
        [
          submission.claimant.name,
          "#{submission.online_total} (Missed #{submission.online_missed})",
          "#{submission.manual_total} (Missed #{submission.manual_missed})",
          submission.total])
    end
  end

  def submissions
    query =
      Submission.select(
        "claimant_id,
        #{filter_online_total},
        #{filter_online_missed},
        #{filter_manual_total},
        #{filter_manual_missed},
        COUNT (*) total")
                .includes(:claimant)
                .where(task: @task)
                .where("claimant_id is not null")

    query = filter_by_part(query)
    query = filter_by_completed_at(query)
    query.group(:claimant_id)
  end

  def filter_online_total
    "COUNT (*) FILTER (WHERE submissions.source = 'online') AS online_total"
  end

  def filter_online_missed
    "COUNT (*) FILTER "\
    "(WHERE submissions.source = 'online' AND #{target_date_missed}) "\
    "AS online_missed"
  end

  def filter_manual_total
    "COUNT (*) FILTER (WHERE submissions.source = 'manual_entry') "\
    "AS manual_total"
  end

  def filter_manual_missed
    "COUNT (*) FILTER "\
    "(WHERE submissions.source = 'manual' AND #{target_date_missed}) "\
    "AS manual_missed"
  end

  def target_date_missed
    "submissions.completed_at > submissions.target_date"
  end
end
