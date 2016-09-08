# Preview all emails at http://localhost:3000/rails/mailers/notification
class EmailTemplatesPreview < ActionMailer::Preview
  def outstanding_declaration
    NotificationMailer.outstanding_declaration(
      email, name, "a-very-long-id")
  end

  def cancellation_owner_request_with_additional_info
    NotificationMailer.cancellation_owner_request(
      email, name, "This is some additional info")
  end

  def cancellation_no_response
    NotificationMailer.cancellation_no_response(email, name)
  end

  def referral_unknown_vessel_type
    NotificationMailer.referral_unknown(email, name)
  end

  def referral_length_and_vessel_type_do_not_match
    NotificationMailer.referral_no_match(email, name)
  end

  def referral_hull_identification_number_appears_incorrect
    NotificationMailer.referral_incorrect(email, name)
  end

  def rejection_unsuitable_name
    NotificationMailer.rejection_unsuitable(email, name)
  end

  def rejection_too_long
    NotificationMailer.rejection_too_long(email, name)
  end

  def rejection_fraudulent
    NotificationMailer.rejection_fraudulent(email, name)
  end

  private

  def email
    "sample@example.com"
  end

  def name
    "Alice"
  end
end
