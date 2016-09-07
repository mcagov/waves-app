class Notification < ApplicationRecord
  belongs_to :submission
  belongs_to :actioned_by, class_name: "User"

  include ActiveModel::Transitions

  state_machine auto_scopes: true do
    state :queued
    state :delivered

    event :deliver do
      transitions to: :delivered, from: :queued,
                  on_transition: :send_email
    end
  end

  def send_email
    NotificationMailer.delay.test_email("test@example.com")
  end

  # while the due_by date *belongs* in the Notification::Referral model
  # it is here so we can create a Notification in the modal without
  # caring about the type, thereby, sending everything to the
  # Notifications and have one notification_params accessor
  def due_by
    30.days.from_now
  end
end
