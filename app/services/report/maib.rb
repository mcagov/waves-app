class Report::Maib < Report
  def initialize(filters = {})
    super
    @report_type = load_report(@filters[:maib_report_type])
  end

  def title
    "MAIB"
  end

  def filter_fields
    [:filter_date_range, :filter_maib_report_type]
  end

  def headings
    ["Date From", "Date To", "Report Type", "Action"]
  end

  def report_types
    [
      ["Fishing Vessel Closures", :maib_vessel_closures],
      ["Fishing Vessel Length", :maib_vessel_length],
      ["Quarterly Report", :maib_quarterly],
    ]
  end

  def results
    return [] unless @date_start && @date_end && @report_type

    [
      Result.new(
        [
          @date_start,
          @date_end,
          @report_type[0],
          RenderAsDownloadLink.new(@report_type[1])]),
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
