class Notification::Rejection < Notification
  REASONS = [
    :unsuitable_name,
    :too_long,
    :fraudulent].freeze

  def email_template
    case subject.to_sym
    when :unsuitable_name
      :rejection_unsuitable
    when :too_long
      :rejection_too_long
    when :fraudulent
      :rejection_fraudulent
    end
  end

  def additional_params
    body
  end

  def email_subject
    "Application Rejected"
  end
end
