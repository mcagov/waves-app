class Report::TonnageStatisticByFleet < Report
  def initialize(filters = {})
    @fleet = filters[:fleet] || :p1_merchant
    super
  end

  def title
    "Tonnage Statistics: #{Register::Fleet.new(@fleet)}"
  end

  def headings
    ["Vessel Name", "Age of Vessel", "Gross Tonnage"]
  end
end
