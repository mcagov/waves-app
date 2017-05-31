class Submission::Approval
  include ActiveModel::Model

  attr_accessor(
    :notification_attachments,
    :registration_starts_at,
    :closure_at,
    :closure_reason,
    :supporting_info
  )
end
