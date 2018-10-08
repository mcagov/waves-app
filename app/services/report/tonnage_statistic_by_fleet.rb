class Report::TonnageStatisticByFleet < Report
  def initialize(filters = {})
    @fleet = Register::Fleet.new(filters[:fleet] || :p1_merchant)
    super
  end

  def title
    "Tonnage Statistics: #{@fleet}"
  end

  # prevent weird charactes in excel worksheet
  def first_sheet_title
    "Tonnage Statistics"
  end

  def headings
    ["Vessels", "Age of Vessel", "Gross Tonnage"]
  end

  def results
    vessels_in_fleet.map do |vessel|
      data_elements =
        [
          RenderAsLinkToVessel.new(vessel, :name),
          age_of(vessel).to_f.round(2),
          (vessel.gross_tonnage || 0).to_f.round(2)]

      Result.new(data_elements)
    end
  end

  def vessels_in_fleet
    return [] unless @fleet
    query = @fleet.report_query_filter(Register::Vessel)
    registration_filter(query).order("vessels.name")
  end

  def registration_filter(query)
    query.where(
      "vessels.id IN (SELECT DISTINCT vessel_id FROM registrations "\
      "WHERE registered_until > now() AND closed_at IS NULL)")
  end

  def age_of(vessel)
    return 0 unless vessel.keel_laying_date
    (Time.zone.today - vessel.keel_laying_date.to_date) / 365
  end
end
