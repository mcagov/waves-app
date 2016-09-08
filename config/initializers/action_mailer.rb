Rails.application.config.action_mailer.delivery_method = :smtp

Rails.application.config.action_mailer.smtp_settings = {
  address:              ENV.fetch("SMTP_ADDRESS"),
  port:                 587,
  domain:               ENV.fetch("SMTP_DOMAIN"),
  user_name:            ENV.fetch("SMTP_USERNAME"),
  password:             ENV.fetch("SMTP_PASSWORD") }

Rails.application.config.action_mailer.default_url_options = {
  host: ENV.fetch("APPLICATION_HOST") }

Rails.application.config.action_mailer.asset_host =
  ENV.fetch("ASSET_HOST")

if ENV.fetch("PREVIEW_EMAILS") == "on"
  Rails.application.config.action_mailer.show_previews = true
  Rails.application.config.consider_all_requests_local = true
  Rails.application.config.action_mailer.preview_path =
    "#{Rails.root}/spec/mailers/previews"
end
