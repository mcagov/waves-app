class Notification::Referral < Notification
  REASONS = [
    :unknown_vessel_type,
    :length_and_vessel_type_do_not_match,
    :hull_identification_number_appears_incorrect].freeze
end
