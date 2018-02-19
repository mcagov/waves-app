class Notification::Referral < Notification
  REASONS = [
    "Awaiting completed C&M Notice",
    "Awaiting certificate of measurement",
    "Documents not filled in correctly",
    "Missing documentation",
    "Fee incorrect or missing",
    "Hull identification number appears incorrect",
    "Length and vessel type do not match",
    "Missing survey",
    "Name and/or port of choice invalid",
    "Unknown vessel type",
  ].freeze

  def email_template
    :wysiwyg
  end

  def additional_params
    [body, actioned_by]
  end

  def email_subject
    "Application Referred - Action Required: #{vessel_name}"
  end

  private

  def vessel_name
    notifiable.vessel_name if notifiable
  end
end
