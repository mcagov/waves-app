# Preview all emails at http://localhost:3000/rails/mailers/notification
class EmailTemplatesPreview < ActionMailer::Preview
  def outstanding_declaration
    NotificationMailer.outstanding_declaration(
      default_params, "a-very-long-id", "Jolly Roger", "Captain Pugwash")
  end

  def application_receipt
    NotificationMailer.application_receipt(
      default_params, "My Boat", "3N-777EA4")
  end

  def application_approval
    NotificationMailer.application_approval(
      default_params, "<p>FREE TEXT</p>", "3N-777EA4")
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
      default_params, "My Boat", 90.days.from_now, "attachment")
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
