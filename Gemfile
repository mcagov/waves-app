source "https://rubygems.org"

ruby "2.3.1"

gem "rails", "~> 5.0.0.1"
gem "bundler-audit", ">= 0.5.0", require: false
gem "bootstrap-sass", "~> 3.3.6"
gem "clearance"
gem "countries"
gem "country_select"
gem "dotenv-rails"
gem "flutie"
gem "font-awesome-rails"
gem "jquery-rails"
gem "pg"
gem "rake"
gem "sass-rails", "~> 5.0"
gem "simple_form"
gem "sprockets", "3.6.3"
gem "sprockets-es6"
gem "title"
gem "uglifier"
gem "validates_email_format_of"
gem "nokogiri", ">= 1.6.8"
gem "haml"
gem 'active_model_serializers', '~> 0.10.0'
gem 'rack-cors'
gem "auto_increment"
gem "transitions", :require => ["transitions", "active_model/transitions"]
gem 'bootstrap-datepicker-rails'

group :development do
  gem "rubocop"
  gem "web-console"
  gem "i18n-debug", require: false
end

group :development, :test do
  gem "awesome_print"
  gem "bullet"
  gem "factory_girl"
  gem "factory_girl_rails"
  gem "pry-byebug"
  gem "pry-rails"
  gem "rspec-rails"
  gem "faker"
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
  gem "rails-controller-testing"
end

group :staging, :production do
  gem "rack-timeout"
end
