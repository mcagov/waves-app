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

  def application_receipt_mortgage
    NotificationMailer.application_receipt(
      default_params,
      "My Boat", "3N-777EA4", true, :mortgage
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

  def application_approval_new_registration
    NotificationMailer.application_approval(
      default_params, "SRXXXXXX", "Officer Bob", :new_registration, "MV Bob"
    )
  end

  def application_approval_renewal
    NotificationMailer.application_approval(
      default_params, "SRXXXXXX", "Officer Bob", :renewal, "MV Bob"
    )
  end

  def application_approval_re_registration
    NotificationMailer.application_approval(
      default_params, "SRXXXXXX", "Officer Bob", :re_registration, "MV Bob"
    )
  end

  def application_approval_change_owner
    NotificationMailer.application_approval(
      default_params, "SRXXXXXX", "Officer Bob", :change_owner, "MV Bob"
    )
  end

  def application_approval_change_vessel
    NotificationMailer.application_approval(
      default_params, "SRXXXXXX", "Officer Bob", :change_vessel, "MV Bob"
    )
  end

  def application_approval_change_address
    NotificationMailer.application_approval(
      default_params, "SRXXXXXX", "Officer Bob", :change_address, "MV Bob"
    )
  end

  def application_approval_closure
    NotificationMailer.application_approval(
      default_params, "SRXXXXXX", "Officer Bob", :closure, "MV Bob"
    )
  end

  def application_approval_current_transcript
    NotificationMailer.application_approval(
      default_params, "SRXXXXXX", "Officer Bob", :current_transcript, "MV Bob"
    )
  end

  def application_approval_historic_transcript
    NotificationMailer.application_approval(
      default_params, "SRXXXXXX", "Officer Bob", :historic_transcript, "MV Bob"
    )
  end

  def application_approval_mortgage
    NotificationMailer.application_approval(
      default_params, "SRXXXXXX", "Officer Bob", :mortgage, "MV Bob"
    )
  end

  def carving_and_marking_note
    NotificationMailer.carving_and_marking_note(
      default_params, "Officer Bob", :pdf_attachment)
  end

  def name_approval
    NotificationMailer.name_approval(
      default_params, "Officer Bob", "MV Bob", "Southampton"
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
      part: :part_2,
    }
  end
end
# rubocop:enable all
