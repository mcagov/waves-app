class Notification < ApplicationRecord
  attr_accessor :actionable_at

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

  def email_subject
    self.class.to_s.demodulize
  end
end
