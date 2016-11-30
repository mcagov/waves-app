# Preview all emails at http://localhost:3000/rails/mailers/notification
# rubocop:disable all
class EmailTemplatesPreview < ActionMailer::Preview
  def outstanding_declaration
    NotificationMailer.outstanding_declaration(
      default_params, "a-very-long-id", "Jolly Roger", "Captain Pugwash")
  end

  def application_receipt_new_registration
    NotificationMailer.application_receipt(
      default_params,
      "My Boat", "3N-777EA4", true, :new_registration
    )
  end

  def application_receipt_renewal
    NotificationMailer.application_receipt(
      default_params,
      "My Boat", "3N-777EA4", true, :renewal
    )
  end

  def application_receipt_change_owner
    NotificationMailer.application_receipt(
      default_params,
      "My Boat", "3N-777EA4", true, :change_owner
    )
  end

  def application_receipt_change_vessel
    NotificationMailer.application_receipt(
      default_params,
      "My Boat", "3N-777EA4", true, :change_vessel
    )
  end

  def application_receipt_change_address
    NotificationMailer.application_receipt(
      default_params,
      "My Boat", "3N-777EA4", true, :change_address
    )
  end

  def application_receipt_re_registration
    NotificationMailer.application_receipt(
      default_params,
      "My Boat", "3N-777EA4", true, :re_registration
    )
  end

  def application_receipt_closure
    NotificationMailer.application_receipt(
      default_params,
      "My Boat", "3N-777EA4", true, :closure
    )
  end

  def application_receipt_current_transcript
    NotificationMailer.application_receipt(
      default_params,
      "My Boat", "3N-777EA4", true, :current_transcript
    )
  end

  def application_receipt_current_transcript
    NotificationMailer.application_receipt(
      default_params,
      "My Boat", "3N-777EA4", true, :current_transcript
    )
  end

  def application_receipt_historic_transcript
    NotificationMailer.application_receipt(
      default_params,
      "My Boat", "3N-777EA4", true, :historic_transcript
    )
  end

  def application_receipt_duplicate_certificate
    NotificationMailer.application_receipt(
      default_params,
      "My Boat", "3N-777EA4", true, :duplicate_certificate
    )
  end

  def application_receipt_enquiry
    NotificationMailer.application_receipt(
      default_params,
      "My Boat", "3N-777EA4", true, :enquiry
    )
  end

  def application_approval
    NotificationMailer.application_approval(
      default_params, "SRXXXXXX", "Officer Bob", "new_registration"
    )
  end

  def wysiwyg
    NotificationMailer.wysiwyg(
      default_params, "<p>Line 1.</p><p>Line 2.</p>", "Alice Abbot")
  end

  private

  def default_params
    {
      subject: "email subject",
      to: "alice@example.com",
      name: "Alice",
    }
  end
end
# rubocop:enable all
