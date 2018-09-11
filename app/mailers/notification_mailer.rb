class NotificationMailer < ApplicationMailer
  helper :mailer

  default from: ENV.fetch("EMAIL_FROM")

  def test_email(email)
    @department = Department.new(:part_3)
    mail(to: email, subject: "Message from the MCA")
  end

  def outstanding_declaration(
      defaults, declaration_id, vessel_name, correspondent_name)
    @department = defaults[:department]
    @name = defaults[:name]
    @declaration_url =
      govuk_url("/referral/outstanding_declaration/#{declaration_id}")
    @vessel_name = vessel_name
    @correspondent_name = correspondent_name

    mail(to: defaults[:to], subject: defaults[:subject])
  end

  def application_receipt(defaults, vessel_name, submission_ref_no)
    @department = defaults[:department]
    @vessel_name = vessel_name
    @submission_ref_no = submission_ref_no
    @name = defaults[:name]

    mail(to: defaults[:to], subject: defaults[:subject])
  end

  def application_approval(defaults, body, actioned_by, pdf_attachments = [])
    @department = defaults[:department]
    @body = body
    @name = defaults[:name]
    @actioned_by = actioned_by
    @application_approval = true
    enable_attachment(pdf_attachments)

    mail(
      to: defaults[:to], subject: defaults[:subject], template_name: :wysiwyg)
  end

  def wysiwyg(defaults, body, actioned_by, pdf_attachments = [])
    @department = defaults[:department]
    @body = body
    @name = defaults[:name]
    @actioned_by = actioned_by
    enable_attachment(pdf_attachments)

    mail(to: defaults[:to], subject: defaults[:subject])
  end

  def carving_and_marking_note(defaults, register_length, actioned_by,
                               pdf_attachment)
    @department = defaults[:department]
    @name = defaults[:name]
    @actioned_by = actioned_by
    @register_length = register_length
    attachments["carving_and_marking_note.pdf"] = pdf_attachment

    mail(to: defaults[:to], subject: defaults[:subject])
  end

  def carving_and_marking_reminder(defaults, vessel_name, reg_no)
    @name = defaults[:name]
    @vessel_name = vessel_name
    @reg_no = reg_no

    mail(to: defaults[:to], subject: defaults[:subject])
  end

  def code_certificate_reminder(defaults, vessel_name, reg_no)
    @name = defaults[:name]
    @vessel_name = vessel_name
    @reg_no = reg_no

    mail(to: defaults[:to], subject: defaults[:subject])
  end

  def safety_certificate_reminder(defaults, vessel_name, reg_no)
    @name = defaults[:name]
    @vessel_name = vessel_name
    @reg_no = reg_no

    mail(to: defaults[:to], subject: defaults[:subject])
  end

  def renewal_reminder(defaults, vessel_name, registered_until, pdf_attachment)
    @name = defaults[:name]
    @vessel_name = vessel_name
    @registered_until = registered_until
    attachments["renewal_letter.pdf"] = pdf_attachment

    mail(to: defaults[:to], subject: defaults[:subject])
  end

  private

  def govuk_url(path)
    File.join(ENV.fetch("GOVUK_HOST"), path)
  end

  def enable_attachment(files)
    return if files.nil?
    Array(files).each_with_index do |file, index|
      attachments["mca-document-#{index + 1}.pdf"] = file
    end
    @attachment = true
    attachments
  end
end
