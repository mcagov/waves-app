class Report::TonnageStatistic < Report
  def title
    "Tonnage Statistics"
  end

  def headings
    ["Fleet", "Gross Tonnage", "Number of Vessels", "Average Age of Vessels"]
  end

  def results
    FLEETS.map do |fleet|
      Result.new([fleet[0]])
    end
  end

  # rubocop:disable all
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
    ["Total Part 1 Pleasure vessels", :p1_merchant],
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

    ["Total Number of Vessels on the Registry", :all]].freeze
  # rubocop:enable all
end
