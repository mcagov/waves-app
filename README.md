# Waves Internal App

## About

This app currently consists of a vessel submission API and a content
management system. The API is intended to support on the
Gov.UK hosted website as a means for the owner of a (singley owned) small ship to
register their vessel under **Part III of the UK Ships Register**. The content
management system is intended to be a means of managing the register and
workload of officers of the [Maritime and Coastguard Agency][mca].

[mca]: https://www.gov.uk/government/organisations/maritime-and-coastguard-agency

## Architecture

This is a standard Rails 5.0 web app with a PostgreSQL database.

#### Style

[Bootstrap][bootstrap] has been used to theme the internal dashboard.

[bootstrap]: https://getbootstrap.com/

## Setup

To set up a new development environment, follow the steps below:

    bundle install
    cp .env.example .env
    cp config/database.yml.example config/database.yml

Then complete the `.env` file with your environment settings, and complete the
`config/database.yml` file with your database settings.

Setup your databases with:

    bundle exec rake db:setup
    bundle exec rake db:test:prepare

### Installation issues

If capybara-webkit fails when you run `bundle install`, refer to the [capybara-webkit help page](https://github.com/thoughtbot/capybara-webkit/wiki/Installing-Qt-and-compiling-capybara-webkit)

## Running the webserver locally

The Puma webserver can be used to run the app locally:

    bundle exec rails server

The app will then be available at http://localhost:3000/

## Testing

We use RSpec for tests. To run the test suite, run:

    bundle exec rspec

If you get the error `DATABASE_URL environment variable is set` you will need to remove the `DATABASE_URL` from the local .env file.

## API / CORS

We are using the [rack-cors](https://github.com/cyu/rack-cors) gem.

CORS is configured in `config/initalisers/cors.rb` and the origins are defined by `ENV['CORS_ORIGINS']`.

## Email previews

Emails can be previewed at: /rails/mailers in development.

## Cron jobs

Cron jobs are managed with the [whenever](https://github.com/javan/whenever) gem.

To ensure the crontab is kept up to date, ensure that `whenever --update-crontab` is called on deployment.

#### Referred applications

Schedule: Daily

If the `submission#referred_until` date has been reached, applications should be restored to the unclaimed tasks queue. To run this task:

  `rake waves:expire_referrals`

