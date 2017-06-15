class Report::TonnageStatistic < Report
  def title
    "Tonnage Statistics"
  end

  def headings
    ["Fleet", "Number of Vessels", "Gross Tonnage", "Average Age of Vessels"]
  end

  def results
    FLEETS.map do |fleet|
      result = load_result(fleet[1])
      data_elements =
        [
          fleet[0],
          result[0],
          result[1].to_f.round(2),
          result[2].to_f.round(2)]

      Result.new(data_elements)
    end
  end

  # rubocop:disable Metrics/LineLength
  FLEETS = [
    ["Part I Merchant vessels under 100gt (R)", :p1_merchant_under_100_gt_registered],
    ["Part I Merchant vessels under 100gt (F)", :p1_merchant_under_100_gt_frozen],
    ["Total Part 1 Merchant vessels under 100gt (F)", :p1_merchant_under_100_gt],

    ["Part I Merchant vessels 100 - 499gt (R)", :p1_merchant_100_to_499_gt_registered],
    ["Part I Merchant vessels 100 - 499gt (F)", :p1_merchant_100_to_499_gt_frozen],
    ["Total Part 1 Merchant vessels 100 - 499gt  (F)", :p1_merchant_100_to_499_gt],

    ["Part I Merchant vessels 500gt and over (R)", :p1_merchant_over_500_gt_registered],
    ["Part I Merchant vessels 500gt and over (F)", :p1_merchant_over_500_gt_frozen],
    ["Total Part 1 Merchant vessels 500gt and over", :p1_merchant_over_500_gt],

    ["Total Part 1 Merchant vessels", :p1_merchant],
    ["Total Part 1 Pleasure vessels", :p1_pleasure],
    ["Part I Grand Total (Merchant and Pleasure", :p1],

    ["Part II Fishing Vessels (<15m) (overall length)", :p2_under_15m],
    ["Part II Fishing Vessels (15-24m) (overall length)", :p2_between_15m_24m],
    ["Part II Fishing Vessels (>24m) (overall length)", :p2_over_24m],
    ["Total Part II Fishing Vessels", :p2],

    ["Total Part III Small Ships", :p2],

    ["Part IV Bareboat Charter Merchant (R)", :p4_merchant_registered],
    ["Part IV Bareboat Charter Merchant (F)", :p4_merchant_frozen],
    ["Part IV Bareboat Charter Fishing (R)", :p4_fishing_registered],
    ["Part IV Bareboat Charter Fishing (F)", :p4_fishing_frozen],
    ["Total Part IV Bareboat Charter", :p4],

    ["All Vessels on the Registry (R)", :registered],
    ["All Vessels on the Registry (F)", :frozne]].freeze
  # rubocop:enable Metrics/LineLength

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

    query = query.where(merchant) if key =~ /.*merchant.*/
    query = query.where(pleasure) if key =~ /.*pleasure.*/

    query = query.where(under_100_gt) if key =~ /.*under_100_gt.*/
    query = query.where(between_100_to_499_gt) if key =~ /.*100_to_499_gt.*/
    query = query.where(over_500_gt) if key =~ /.*over_500_gt.*/

    query = query.not_frozen if key =~ /.*registered/
    query = query.frozen if key =~ /.*_frozen/

    query
  end
  # rubocop:enable all

  def merchant
    "registration_type = 'commercial'"
  end

  def pleasure
    "registration_type = 'pleasure'"
  end

  def under_100_gt
    "COALESCE(gross_tonnage, 0) < 100"
  end

  def between_100_to_499_gt
    "COALESCE(gross_tonnage, 0) BETWEEN 100 AND 499.999"
  end

  def over_500_gt
    "COALESCE(gross_tonnage, 0) >= 500"
  end

  def registration_filter(query)
    query.where(
      "vessels.id IN (SELECT DISTINCT vessel_id FROM registrations "\
      "WHERE registered_until > now() AND closed_at IS NULL)")
  end
end
