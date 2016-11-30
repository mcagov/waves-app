# Preview all emails at http://localhost:3000/rails/mailers/notification
class EmailTemplatesPreview < ActionMailer::Preview
  def outstanding_declaration
    NotificationMailer.outstanding_declaration(
      default_params, "a-very-long-id", "Jolly Roger", "Captain Pugwash")
  end

  def application_receipt
    NotificationMailer.application_receipt(
      default_params,
      "My Boat", "3N-777EA4", true
    )
  end

  def application_approval
    NotificationMailer.application_approval(
      default_params, "SRXXXXXX", "Officer Bob"
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
