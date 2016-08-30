class Notification < ApplicationRecord
  belongs_to :submission
  belongs_to :actioned_by, class_name: "User"

  # while the due_by date *belongs* in the Notification::Referral model
  # it is here so we can create a Notification in the modal without
  # caring about the type, thereby, sending everything to the
  # Notifications and have one notification_params accessor
  def due_by
    30.days.from_now
  end
end
