module MessageHelper
  include MailerHelper

  def default_email_text(notification_type, submission)
    case notification_type
    when :cancel
      cancel_email_text(submission)
    when :refer
      refer_email_text(submission)
    when :application_approval
      application_approval_email_text(submission)
    end
  end

  def cancel_email_text(submission)
    %(<div>Thank you for your application regarding the vessel
      #{submission.vessel}
      <br><br>Please note that your application has been cancelled
      for the following reason/s
      <br><br>
      [FREE TEXT]
      <br><br>Where applicable the fee will be refunded using the same
      method and to the same payee as the original payment.
      <br><br>If you require any further assistance please do not
      hesitate to contact us at #{contact_us_for_part}.
      <br><br>Please quote your application reference
      #{submission.ref_no} in all correspondence.</div>)
  end

  def refer_email_text(submission)
    %(<div>Thank you for your application regarding the vessel
      #{submission.vessel}
      <br><br>In order for us to proceed with your application we
      will require the following:
      <br><br>
      [FREE TEXT]
      <br><br>If you require any further assistance please do not
      hesitate to contact us at #{contact_us_for_part}.
      <br><br>Please quote your application reference
      #{submission.ref_no} in all correspondence.</div>)
  end

  def application_approval_email_text(submission)
    %(<div>Thank you for your application regarding the vessel
      #{submission.vessel}.
      <br><br>Your application has now been completed.)
  end

  def emailable_attachments(submission)
    templates = submission.print_jobs.map { |p| p.template.to_sym }
    [
      :registration_certificate, :provisional_certificate,
      :duplicate_registration_certificate,
      :current_transcript, :historic_transcript
    ].select { |attachment| templates.include?(attachment) }
  end
end
