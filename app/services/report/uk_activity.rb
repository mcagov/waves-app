class Report::UkActivity < Report
  def title
    "UK Activity"
  end

  def sub_report
    [:uk_activity_report_by_type]
  end

  def filter_fields
    [:filter_date_range]
  end

  def headings
    %w(Type Total)
  end

  def results
    return [] unless @date_start && @date_end

    UkActivityReportByType::REPORT_TYPES.map do |report_type|
      Result.new(
        [report_type[0], submissions_count(report_type[1])],
        activity_report_type: report_type[1])
    end
  end

  private

  def submissions_count(uk_activity_report_type)
    UkActivityReportByType
      .new(activity_report_type: uk_activity_report_type)
      .submission_scope.count
  end
end
