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

  def application_approval
    NotificationMailer.application_approval(
      Notification::ApplicationApproval.new.email_subject,
      email, name, "SRXXXXXX"
    )
  end

  def wysiwyg
    NotificationMailer.wysiwyg(
      "WYSIWYG", email, name, "<p>Line 1.</p><p>Line 2.</p>")
  end

  private

  def email
    "sample@example.com"
  end

  def name
    "Alice"
  end
end
