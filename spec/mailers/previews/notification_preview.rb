# Preview all emails at http://localhost:3000/rails/mailers/notification
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

  def application_receipt
    NotificationMailer.application_receipt(
      default_params, "My Boat", "3N-777EA4")
  end

  def application_approval_new_registration
    NotificationMailer.application_approval(
      default_params, "SRXXXXXX", "Officer Bob", :new_registration, "MV Bob"
    )
  end

  def application_approval_provisional
    NotificationMailer.application_approval(
      default_params, "SRXXXXXX", "Officer Bob", :provisional, "MV Bob"
    )
  end

  def application_approval_simple_to_full
    NotificationMailer.application_approval(
      default_params, "SRXXXXXX", "Officer Bob", :simple_to_full, "MV Bob"
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

  def carving_and_marking_note_under_15m
    NotificationMailer.carving_and_marking_note(
      default_params, 14.9, "Officer Bob", :pdf_attachment)
  end

  def carving_and_marking_note_15_to_24m
    NotificationMailer.carving_and_marking_note(
      default_params, 24, "Officer Bob", :pdf_attachment)
  end

  def carving_and_marking_note_over_24m
    NotificationMailer.carving_and_marking_note(
      default_params, 55, "Officer Bob", :pdf_attachment)
  end

  def carving_and_marking_reminder
    NotificationMailer.carving_and_marking_reminder(
      default_params, "My Boat", "3N-777EA4")
  end

  def code_certificate_reminder
    NotificationMailer.code_certificate_reminder(
      default_params, "My Boat", "3N-777EA4")
  end

  def safety_certificate_reminder
    NotificationMailer.safety_certificate_reminder(
      default_params, "My Boat", "3N-777EA4")
  end

  def renewal_reminder
    NotificationMailer.renewal_reminder(
      default_params, "My Boat", 90.days.from_now)
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
      department: Department.new(:part_2, :full),
    }
  end
end
