# Preview all emails at http://localhost:3000/rails/mailers/notification
class EmailTemplatesPreview < ActionMailer::Preview
  def outstanding_declaration
    NotificationMailer.outstanding_declaration(
      Notification::OutstandingDeclaration.new.email_subject,
      email, name, "a-very-long-id", "Jolly Roger", "Captain Pugwash")
  end

  def application_receipt
    NotificationMailer.application_receipt(
      Notification::ApplicationReceipt.new.email_subject,
      email, name, "Jolly Roger",
      "8481b725-e7c8-4c94-b311-9fa2f10748ae", "3N-777EA4"
    )
  end

  def cancellation_owner_request_with_additional_info
    NotificationMailer.cancellation_owner_request(
      Notification::Cancellation.new.email_subject,
      email, name, "This is some additional info")
  end

  def cancellation_owner_request
    NotificationMailer.cancellation_owner_request(
      Notification::Cancellation.new.email_subject,
      email, name)
  end

  def cancellation_no_response
    NotificationMailer.cancellation_no_response(
      Notification::Cancellation.new.email_subject, email, name)
  end

  def referral_unknown_vessel_type
    NotificationMailer.referral_unknown(
      Notification::Referral.new.email_subject, email, name)
  end

  def referral_length_and_vessel_type_do_not_match
    NotificationMailer.referral_no_match(
      Notification::Referral.new.email_subject, email, name)
  end

  def referral_hull_identification_number_appears_incorrect
    NotificationMailer.referral_incorrect(
      Notification::Referral.new.email_subject, email, name)
  end

  def rejection_unsuitable_name
    NotificationMailer.rejection_unsuitable(
      Notification::Rejection.new.email_subject, email, name)
  end

  def rejection_too_long
    NotificationMailer.rejection_too_long(
      Notification::Rejection.new.email_subject, email, name)
  end

  def rejection_fraudulent
    NotificationMailer.rejection_fraudulent(
      Notification::Rejection.new.email_subject, email, name)
  end

  private

  def email
    "sample@example.com"
  end

  def name
    "Alice"
  end
end
