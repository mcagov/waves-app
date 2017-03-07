class NotificationMailer < ApplicationMailer
  helper :mailer

  default from: ENV.fetch("EMAIL_FROM")

  def test_email(email)
    mail(to: email, subject: "Message from the MCA")
  end

  def outstanding_declaration(
      defaults, declaration_id, vessel_name, correspondent_name)
    @name = defaults[:name]
    @declaration_url =
      govuk_url("/referral/outstanding_declaration/#{declaration_id}")
    @vessel_name = vessel_name
    @correspondent_name = correspondent_name

    mail(to: defaults[:to], subject: defaults[:subject])
  end

  def application_receipt(defaults, vessel_name, submission_ref_no,
                          declarations_required, template_name)
    @vessel_name = vessel_name
    @submission_ref_no = submission_ref_no
    @name = defaults[:name]
    @declarations_required = declarations_required

    mail(to: defaults[:to],
         subject: defaults[:subject],
         template_path: "notification_mailer/application_receipt",
         template_name: template_name)
  end

  def application_approval(defaults, reg_no, actioned_by, template_name,
                           vessel_name, pdf_attachment = nil)
    @reg_no = reg_no
    @name = defaults[:name]
    @actioned_by = actioned_by
    @vessel_name = vessel_name
    # rubocop:disable Lint/UselessAssignment
    attachments = enable_attachment(pdf_attachment)

    mail(to: defaults[:to], subject: defaults[:subject],
         template_path: "notification_mailer/application_approval",
         template_name: template_name)
  end

  def wysiwyg(defaults, body, actioned_by)
    @body = body
    @name = defaults[:name]
    @actioned_by = actioned_by

    mail(to: defaults[:to], subject: defaults[:subject])
  end

  def carving_and_marking_note(defaults, actioned_by, pdf_attachment)
    @name = defaults[:name]
    @actioned_by = actioned_by
    attachments = enable_attachment(pdf_attachment)

    mail(to: defaults[:to], subject: defaults[:subject])
  end

  private

  def govuk_url(path)
    File.join(ENV.fetch("GOVUK_HOST"), path)
  end

  def enable_attachment(attachment)
    return if attachment.nil?
    attachments["#{@reg_no}.pdf"] = attachment
    @attachment = true
    attachments
  end
end
