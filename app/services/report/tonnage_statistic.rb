class Report::TonnageStatistic < Report
  def title
    "Tonnage Statistics"
  end

  def headings
    ["Fleet", "Number of Vessels", "Average Age of Vessels", "Gross Tonnage"]
  end

  def sub_report
    :tonnage_statistic_by_fleet
  end

  def results
    Register::Fleet::FLEETS.map do |fleet|
      result = load_result(fleet[1])
      data_elements =
        [
          fleet[0],
          result[0],
          result[1].to_f.round(2),
          result[2].to_f.round(2)]

      Result.new(data_elements, fleet: fleet[1])
    end
  end

  def load_result(key)
    query = Register::Fleet.new(key).report_query_filter(Register::Vessel)
    query = query.select(select_query)
    query = registration_filter(query)
    query.map { |r| [r.num_reg, r.age, r.gt] }.first
  end

  def select_query
    [
      "COUNT(*) as num_reg",
      "AVG(COALESCE(now()::DATE - "\
      "keel_laying_date::DATE, 0)::FLOAT / 365) AS age",
      "SUM(gross_tonnage) AS gt",
    ]
  end

  def registration_filter(query)
    query.where(
      "vessels.id IN (SELECT DISTINCT vessel_id FROM registrations "\
      "WHERE registered_until > now() AND closed_at IS NULL)")
  end
end
