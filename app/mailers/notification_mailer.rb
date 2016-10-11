class NotificationMailer < ApplicationMailer
  default from: ENV.fetch("EMAIL_FROM")

  def test_email(email)
    mail(to: email, subject: "Message from the MCA")
  end

  def outstanding_declaration(
      subject, email, name, declaration_id, vessel_name, correspondent_name)
    @name = name
    @declaration_url =
      govuk_url("/referral/outstanding_declaration/#{declaration_id}")
    @vessel_name = vessel_name
    @correspondent_name = correspondent_name

    mail(to: email, subject: subject)
  end

  def application_receipt(subject, email, name, vessel_name,
                          world_pay_transaction_no, submission_ref_no)
    @vessel_name = vessel_name
    @world_pay_transaction_no = world_pay_transaction_no
    @submission_ref_no = submission_ref_no
    @name = name

    mail(to: email, subject: subject)
  end

  def application_approval(subject, email, name, reg_no, actioned_by,
                           pdf_attachment = nil)
    @reg_no = reg_no
    @name = name
    if pdf_attachment
      attachments["Certificate_of_Registration_copy.pdf"] = pdf_attachment
      @certificate_attached = true
    end
    @actioned_by = actioned_by

    mail(to: email, subject: subject)
  end

  def wysiwyg(subject, email, name, body, actioned_by)
    @body = body
    @name = name
    @actioned_by = actioned_by

    mail(to: email, subject: subject)
  end

  private

  def govuk_url(path)
    File.join(ENV.fetch("GOVUK_HOST"), path)
  end
end
