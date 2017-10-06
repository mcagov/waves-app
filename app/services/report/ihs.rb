class Report::Ihs < Report
  def title
    "IHS/Fairplay"
  end

  def headings
    ["Report Type", "Action"]
  end

  def results
    [
      Result.new(
        [
          "IHS/Fairplay Report",
          RenderAsDownloadLink.new(:ihs_report)]),
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
