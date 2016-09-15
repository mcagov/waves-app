class NotificationMailer < ApplicationMailer
  default from: ENV.fetch("EMAIL_FROM")

  def test_email(email)
    mail(to: email, subject: "Message from the MCA")
  end

  def outstanding_declaration(
      subject, email, name, declaration_id, vessel_name, applicant_name)
    @name = name
    @declaration_url =
      govuk_url("/referral/outstanding_declaration/#{declaration_id}")
    @vessel_name = vessel_name
    @applicant_name = applicant_name
    mail(to: email,
         subject: subject)
  end

  def application_receipt(subject, email, name, vessel_name,
                          world_pay_transaction_no, submission_ref_no)
    @vessel_name = vessel_name
    @world_pay_transaction_no = world_pay_transaction_no
    @submission_ref_no = submission_ref_no
    @name = name
    mail(to: email, subject: subject)
  end

  def cancellation_owner_request(subject, email, name, additional_info = nil)
    @additional_info = additional_info
    @name = name
    mail(to: email, subject: subject)
  end

  def cancellation_no_response(subject, email, name, additional_info = nil)
    @additional_info = additional_info
    @name = name
    mail(to: email, subject: subject)
  end

  def referral_incorrect(subject, email, name, additional_info = nil)
    @contact_us_on = "XXX"
    @additional_info = additional_info
    @name = name
    mail(to: email, subject: subject)
  end

  def referral_no_match(subject, email, name, additional_info = nil)
    @contact_us_on = "XXX"
    @additional_info = additional_info
    @name = name
    mail(to: email, subject: subject)
  end

  def referral_unknown(subject, email, name, additional_info = nil)
    @contact_us_on = "XXX"
    @additional_info = additional_info
    @name = name
    mail(to: email, subject: subject)
  end

  def rejection_fraudulent(subject, email, name, additional_info = nil)
    @additional_info = additional_info
    @name = name
    mail(to: email, subject: subject)
  end

  def rejection_too_long(subject, email, name, additional_info = nil)
    @additional_info = additional_info
    @name = name
    mail(to: email, subject: subject)
  end

  def rejection_unsuitable(subject, email, name, additional_info = nil)
    @additional_info = additional_info
    @name = name
    mail(to: email, subject: subject)
  end

  private

  def govuk_url(path)
    File.join(ENV.fetch("GOVUK_HOST"), path)
  end
end
