class Notification < ApplicationRecord
  attr_accessor :actionable_at

  belongs_to :notifiable, polymorphic: true
  belongs_to :actioned_by, class_name: "User"

  after_create :deliver!

  include ActiveModel::Transitions

  state_machine do
    state :ready_for_delivery
    state :delivered

    event :deliver!, timestamp: true do
      transitions to: :delivered, from: [:ready_for_delivery],
                  on_transition: :send_email,
                  guard: :deliverable?
    end
  end

  def send_email
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
      department: Department.new(
        notifiable.part,
        Policies::Definitions.registration_type(notifiable)),
    }
  end
end
