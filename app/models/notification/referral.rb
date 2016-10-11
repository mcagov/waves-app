class Notification::Referral < Notification
  REASONS = [
    :unknown_vessel_type,
    :length_and_vessel_type_do_not_match,
    :hull_identification_number_appears_incorrect].freeze

  def email_template
    :wysiwyg
  end

  def additional_params
    body
  end

  def email_subject
    "Application Referred - Action Required: #{vessel_name}"
  end

  private

  def vessel_name
    notifiable.vessel.name if notifiable.vessel
  end
end
