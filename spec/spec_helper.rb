if ENV.fetch("COVERAGE", false)
  require "simplecov"

  if ENV["CIRCLE_ARTIFACTS"]
    dir = File.join(ENV["CIRCLE_ARTIFACTS"], "coverage")
    SimpleCov.coverage_dir(dir)
  end

  SimpleCov.start do
    # add_filter "/application_record/"
  end
end

require "webmock/rspec"

# http://rubydoc.info/gems/rspec-core/RSpec/Core/Configuration
RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.syntax = :expect
  end

  config.mock_with :rspec do |mocks|
    mocks.syntax = :expect
    mocks.verify_partial_doubles = true
  end

  config.example_status_persistence_file_path = "tmp/rspec_examples.txt"
  config.order = :random

  config.around(:each) do |example|
    stub_request(:get, "https://www.gov.uk/bank-holidays.json")
      .with(headers: { "Accept" => "*/*", "User-Agent" => "Ruby" })
      .to_return(
        body: File.read("#{Rails.root}/spec/fixtures/govuk_holidays.json"))

    WebMock.disable_net_connect!(allow_localhost: true)

    example.call

    WebMock.allow_net_connect!
  end

  config.after(:suite) do
    FileUtils.rm_rf(Dir["#{Rails.root}/spec/test_files/"])
  end
end
