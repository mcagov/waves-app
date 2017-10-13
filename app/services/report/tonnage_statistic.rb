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
    query = vessel_filter(Register::Vessel, key)
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

  # rubocop:disable all
  def vessel_filter(query, key)
    query = query.in_part(:part_1) if key =~ /^p1.*/
    query = query.in_part(:part_2) if key =~ /^p2.*/
    query = query.in_part(:part_3) if key =~ /^p3.*/
    query = query.in_part(:part_4) if key =~ /^p4.*/

    query = query.where(p1_merchant) if key =~ /^p1_merchant.*/
    query = query.where(p1_pleasure) if key =~ /^p1_pleasure.*/

    query = query.where(p4_merchant) if key =~ /^p4_merchant.*/
    query = query.where(p4_fishing) if key =~ /^p4_fishing.*/
    query = query.where(p4_pleasure) if key =~ /^p4_pleasure.*/

    query = query.where(under_100gt) if key =~ /.*under_100gt.*/
    query = query.where(from_100_to_499gt) if key =~ /.*100_to_499gt.*/
    query = query.where(over_500gt) if key =~ /.*over_500gt.*/

    query = query.where(under_15m) if key =~ /.*under_15m.*/
    query = query.where(from_15_to_24m) if key =~ /.*between_15_24m.*/
    query = query.where(over_24m) if key =~ /.*over_24m.*/

    query = query.not_frozen if key =~ /.*registered/
    query = query.frozen if key =~ /.*frozen/

    query
  end
  # rubocop:enable all

  def p1_merchant
    "registration_type = 'commercial'"
  end

  def p1_pleasure
    "registration_type = 'pleasure'"
  end

  def p4_merchant
    "registration_type = 'commercial'"
  end

  def p4_fishing
    "registration_type = 'fishing'"
  end

  def p4_pleasure
    "registration_type = 'pleasure'"
  end

  def under_100gt
    "COALESCE(gross_tonnage, 0) < 100"
  end

  def from_100_to_499gt
    "COALESCE(gross_tonnage, 0) BETWEEN 100 AND 499.999"
  end

  def over_500gt
    "COALESCE(gross_tonnage, 0) >= 500"
  end

  def under_15m
    "COALESCE(length_overall, 0) < 15"
  end

  def from_15_to_24m
    "COALESCE(length_overall, 0) BETWEEN 15 AND 23.999"
  end

  def over_24m
    "COALESCE(length_overall, 0) > 24"
  end

  def registration_filter(query)
    query.where(
      "vessels.id IN (SELECT DISTINCT vessel_id FROM registrations "\
      "WHERE registered_until > now() AND closed_at IS NULL)")
  end
end
