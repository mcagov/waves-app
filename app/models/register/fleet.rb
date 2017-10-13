class Register::Fleet
  def initialize(key)
    @key = key.to_sym
  end

  def to_s
    FLEETS.find { |f| f[1] == @key }[0]
  end

  # rubocop:disable Metrics/LineLength
  FLEETS = [
    ["Part I Merchant vessels under 100gt (R)", :p1_merchant_under_100gt_registered],
    ["Part I Merchant vessels under 100gt (F)", :p1_merchant_under_100gt_frozen],
    ["Total Part 1 Merchant vessels under 100gt (F)", :p1_merchant_under_100gt],

    ["Part I Merchant vessels 100 - 499gt (R)", :p1_merchant_100_to_499gt_registered],
    ["Part I Merchant vessels 100 - 499gt (F)", :p1_merchant_100_to_499gt_frozen],
    ["Total Part 1 Merchant vessels 100 - 499gt  (F)", :p1_merchant_100_to_499gt],

    ["Part I Merchant vessels 500gt and over (R)", :p1_merchant_over_500gt_registered],
    ["Part I Merchant vessels 500gt and over (F)", :p1_merchant_over_500gt_frozen],
    ["Total Part 1 Merchant vessels 500gt and over", :p1_merchant_over_500gt],

    ["Total Part 1 Merchant vessels", :p1_merchant],
    ["Total Part 1 Pleasure vessels", :p1_pleasure],
    ["Part I Grand Total (Merchant and Pleasure)", :p1],

    ["Part II Fishing Vessels (<15m) (overall length)", :p2_under_15m],
    ["Part II Fishing Vessels (15-24m) (overall length)", :p2_between_15_24m],
    ["Part II Fishing Vessels (>24m) (overall length)", :p2_over_24m],
    ["Total Part II Fishing Vessels", :p2],

    ["Total Part III Small Ships", :p3],

    ["Part IV Bareboat Charter Merchant (R)", :p4_merchant_registered],
    ["Part IV Bareboat Charter Merchant (F)", :p4_merchant_frozen],
    ["Part IV Bareboat Charter Fishing (R)", :p4_fishing_registered],
    ["Part IV Bareboat Charter Fishing (F)", :p4_fishing_frozen],
    ["Part IV Bareboat Charter Pleasure (R)", :p4_pleasure_registered],
    ["Part IV Bareboat Charter Pleasure (F)", :p4_pleasure_frozen],
    ["Total Part IV Bareboat Charter", :p4],

    ["All Vessels on the Registry (R)", :registered],
    ["All Vessels on the Registry (F)", :frozen]].freeze
  # rubocop:enable Metrics/LineLength
end
