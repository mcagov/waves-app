source "https://rubygems.org"

ruby "2.3.1"

gem "bundler-audit", ">= 0.5.0", require: false
gem "bootstrap-sass", "~> 3.3.6"
gem "clearance"
gem "countries"
gem "dotenv-rails"
gem "flutie"
gem "font-awesome-rails"
gem "govuk_elements_rails"
gem "govuk_frontend_toolkit"
gem "govuk_template"
gem "high_voltage", "~> 3.0.0"
gem "jquery-rails"
gem "pg"
gem "puma"
gem "rails", "~> 4.2.0"
gem "rake", "~> 11.1.2"
gem "recipient_interceptor"
gem "sass-rails", "~> 5.0"
gem "simple_form"
gem "sprockets", ">= 3.0.0"
gem "sprockets-es6"
gem "title"
gem "uglifier"
gem "wicked"

group :development do
  gem "quiet_assets"
  gem "rubocop"
  gem "web-console"
end

group :development, :test do
  gem "awesome_print"
  gem "bullet"
  gem "factory_girl"
  gem "factory_girl_rails"
  gem "pry-byebug"
  gem "pry-rails"
  gem "rspec-rails", "~> 3.4.0"
end

group :development, :staging do
  gem "rack-mini-profiler", require: false
end

group :test do
  gem "capybara-webkit"
  gem "database_cleaner"
  gem "formulaic"
  gem "launchy"
  gem "shoulda-matchers"
  gem "simplecov", require: false
  gem "timecop"
  gem "webmock"
end

group :staging, :production do
  gem "rack-timeout"
end
