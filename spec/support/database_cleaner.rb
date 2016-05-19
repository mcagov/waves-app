RSpec.configure do |config|
  config.before(:suite) do
    DatabaseCleaner.clean_with(:deletion, except: %w(vessel_types))
  end

  config.before(:each) do
    DatabaseCleaner.strategy = :truncation, { except: %w(vessel_types) }
  end

  config.before(:each, js: true) do
    DatabaseCleaner.strategy = :deletion, { except: %w(vessel_types) }
  end

  config.before(:each) do
    DatabaseCleaner.start
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end
end
