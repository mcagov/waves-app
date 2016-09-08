class NotificationMailer < ApplicationMailer
  default from: ENV.fetch("EMAIL_FROM")

  def test_email(email)
    mail(to: email, subject: "Message from the MCA")
  end

  def outstanding_declaration(email, name, declaration_id)
    @name = name
    @declaration_url =
      govuk_url("/referral/outstanding_declaration/#{declaration_id}")
    mail(to: email,
         subject: "Vessel Registration Owner Declaration Required")
  end

  def cancellation_owner_request(email, name, additional_info = nil)
    @additional_info = additional_info
    @name = name
    mail(to: email, subject: "Application Cancelled")
  end

  def cancellation_no_response(email, name, additional_info = nil)
    @additional_info = additional_info
    @name = name
    mail(to: email, subject: "Application Cancelled")
  end

  private

  def govuk_url(path)
    File.join(ENV.fetch("GOVUK_HOST"), path)
  end
end
