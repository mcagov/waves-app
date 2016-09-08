class Notification < ApplicationRecord
  belongs_to :notifiable, polymorphic: true
  belongs_to :actioned_by, class_name: "User"

  after_create :send_email

  validates :recipient_name, presence: true
  validates :recipient_email, presence: true

  def send_email
    NotificationMailer.delay.send(
      email_template,
      recipient_email,
      recipient_name,
      *additional_params)
  end

  def email_template
    :test_email
  end

  def additional_params; end

  # while the due_by date *belongs* in the Notification::Referral model
  # it is here so we can create a Notification in the modal without
  # caring about the type, thereby, sending everything to the
  # Notifications and have one notification_params accessor
  def due_by
    30.days.from_now
  end
end
