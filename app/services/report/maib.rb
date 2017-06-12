class Report::Maib < Report
  def title
    "MAIB"
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
      ["Fishing Vessel Closure", :maib_closure],
      ["Fishing Vessel Length", :maib_length],
      ["Quarterly Report", :maib_quarterly],
    ].map do |name, key|
      Result.new(
        [@date_start, @date_end, name, RenderAsDownloadLink.new(name, key)])
    end
  end
end
