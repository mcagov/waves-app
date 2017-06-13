class Report::VesselAge < Report
  def title
    "Vessel Age"
  end

  def filter_fields
    [:filter_part]
  end

  def headings
    ["Type of Vessel", "Registered", "Average Age", "Gross Tonnage"]
  end
end
