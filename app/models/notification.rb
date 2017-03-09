class Notification < ApplicationRecord
  attr_accessor :actionable_at

  belongs_to :notifiable, polymorphic: true
  belongs_to :actioned_by, class_name: "User"

  after_create :send_email

  def send_email
    return unless deliverable?

    NotificationMailer.delay.send(
      email_template, default_params, *additional_params)
  end

  def email_template
    :test_email
  end

  def additional_params; end

  def email_subject
    self.class.to_s.demodulize
  end

  def deliverable?
    recipient_name.present? && recipient_email.present?
  end

  private

  def default_params
    {
      subject: email_subject,
      to: recipient_email,
      name: recipient_name,
      part: notifiable.part,
    }
  end
end
