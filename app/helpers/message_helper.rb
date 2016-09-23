module MessageHelper
  def default_email_text(notification_type)
    case notification_type
    when :cancel
      cancel_email_text
    when :refer
      refer_email_text
    when :reject
      reject_email_text
    end
  end

  def cancel_email_text
    %(<p>Thank you for your application to register your vessel
      on Part III of the UK Ship Register.</p>
      <p>[CANCELLATION REASON].</p>
      <p>A refund will be processed shortly and you will be notified
      when it has been issued.</p>)
  end

  def refer_email_text
    %(<p>Thank you for your application to register your vessel
      on Part III of the UK Ship Register.</p>
      <p>Your application has been referred for the following reason:
      [REFERRAL REASON]</p>)
  end

  def reject_email_text
    %(<p>Thank you for your application to register your vessel
      on Part III of the UK Ship Register.</p>
      <p>[REJECTION REASON])
  end
end
