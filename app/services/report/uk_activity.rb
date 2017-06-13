class Report::UkActivity < Report
  def title
    "UK Activity"
  end

  def sub_report
    :uk_activity_by_type
  end

  def filter_fields
    [:filter_date_range]
  end

  def headings
    ["Type", "Total"]
  end

  def results
    return [] unless @date_start && @date_end
    [
      Result.new(["All Merchant Flag in", 12], [:merchant_flag_in])
    ]
  end
end
