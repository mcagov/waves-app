Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins ENV['CORS_ORIGINS'] || 'localhost:3000'
    resource '*',
      headers: :any,
      methods: %i(get post put)
  end
end
