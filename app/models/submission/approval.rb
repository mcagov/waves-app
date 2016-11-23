class Submission::Approval
  include ActiveModel::Model

  attr_accessor(
    :notification_attachments,
    :registration_starts_at
  )
end
