class Builders::NotificationBuilder
  class << self
    def application_approval(submission, actioned_by, attachments = "")
      submission.owners.each do |owner|
        Notification::ApplicationApproval.create(
          recipient_email: owner.email,
          recipient_name: owner.name,
          notifiable: submission,
          subject: submission.job_type,
          actioned_by: actioned_by,
          attachments: attachments)
      end
    end
  end
end
