class Notification::Referral < Notification
  REASONS = [
    :unknown_vessel_type,
    :length_and_vessel_type_do_not_match,
    :hull_identification_number_appears_incorrect].freeze

  def email_template
    case subject.to_sym
    when :unknown_vessel_type
      :referral_unknown
    when :length_and_vessel_type_do_not_match
      :referral_no_match
    when :hull_identification_number_appears_incorrect
      :referral_incorrect
    end
  end

  def additional_params
    body
  end

  def email_subject
    "Application Referred - Action Required"
  end
end
