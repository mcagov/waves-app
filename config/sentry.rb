Raven.configure do |c|
  c.dsn = ENV.fetch("SENTRY_DSN")
  c.environments = ['staging', 'production']
  c.sanitize_fields = Rails.application.config.filter_parameters.map(&:to_s)
end
