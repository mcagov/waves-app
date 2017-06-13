class Report::FishingRegional < Report
  def title
    "Fishing Regional"
  end

  def filter_fields
    [:filter_date_range]
  end

  def headings
    ["Date From", "Date To", "Action"]
  end

  def results
    return [] unless @date_start && @date_end

    [
      Result.new(
        [
          @date_start,
          @date_end,
          "Fishing Regional Report",
          RenderAsDownloadLink.new(:fishing_regional_report)]),
    ]
  end

  def links_to_export_or_print?
    false
  end
end
