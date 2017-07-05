class DeviseUserMailer < Devise::Mailer
  layout "devise_mailer"

  include Devise::Controllers::UrlHelpers

  default template_path: "devise/mailer"
  default from: ENV.fetch("EMAIL_FROM")

  def reset_password_instructions(record, token, opts = {})
    super
  end
end
