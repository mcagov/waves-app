module MessageHelper
  def default_email_text(notification_type, submission)
    case notification_type
    when :cancel
      cancel_email_text(submission)
    when :refer
      refer_email_text(submission)
    end
  end

  def cancel_email_text(submission)
    %(<p>Thank you for your application regarding the vessel
      #{submission.vessel}</p>
      <p>Please note that your application has been cancelled
      for the following reason/s</p>
      <p>[FREE TEXT]</p>
      <p>Where applicable the fee will be refunded using the same
      method and to the same payee as the original payment.</p>
      <p>If you require any further assistance please do not
      hesitate to contact us at ssr.registry@mcga.gov.uk.</p>
      <p>Please quote your application reference
      #{submission.ref_no} in all correspondence.</p>)
  end

  def refer_email_text(submission)
    %(<p>Thank you for your application regarding the vessel
      #{submission.vessel}</p>
      <p>In order for us to proceed with your application we
      will require the following:</p>
      <p>[FREE TEXT]</p>
      <p>If you require any further assistance please do not
      hesitate to contact us at ssr.registry@mcga.gov.uk.</p>
      <p>Please quote your application reference
      #{submission.ref_no} in all correspondence.</p>)
  end
end
