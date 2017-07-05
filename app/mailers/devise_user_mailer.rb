class DeviseUserMailer < Devise::Mailer
  default template_path: 'devise/mailer'
  default from: ENV.fetch("EMAIL_FROM")

  def reset_password_instructions(record, token, opts={})
    opts[:subject] = "Waves Account Activation / Setup Password"
    super
  end
end
