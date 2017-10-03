class Report::Cefas < Report
  def title
    "CEFAS"
  end

  def filter_fields
    [:filter_date_range]
  end

  def headings
    ["Date From", "Date To", "Report Type", "Action"]
  end

  def results
    return [] unless @date_start && @date_end

    [
      Result.new(
        [
          @date_start,
          @date_end,
          "CEFAS Report",
          RenderAsDownloadLink.new(:cefas_report)]),
    ]
  end

  def links_to_export_or_print?
    false
  end

  private

  def load_report(report_type_key)
    return unless report_type_key.present?
    report_types.find { |r| r[1] == report_type_key.to_sym }
  end
end
