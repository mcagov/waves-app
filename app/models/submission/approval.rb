class Submission::Approval
  include ActiveModel::Model

  attr_accessor(
    :notification_attachments,
    :registration_starts_at,
    :closure_at,
    :closure_reason
  )

  CLOSURE_REASONS = [
    "Registered Owner Request",
    "Failed to Renew",
    "No Longer Eligible",
    "Non Registered Owner Request"].freeze
end
