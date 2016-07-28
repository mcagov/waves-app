# Waves Internal App

## About

This app currently consists of a vessel registration API and a content
management system. The API is intended to support on the
Gov.UK hosted website as a means for the owner of a (singley owned) small ship to
register their vessel under **Part III of the UK Ships Register**. The content
management system is intended to be a means of managing the register and
workload of officers of the [Maritime and Coastguard Agency][mca].

[mca]: https://www.gov.uk/government/organisations/maritime-and-coastguard-agency

## Architecture

This is a standard Rails 5.0 web app with a PostgreSQL database.

#### Database model

The expected database model for the app is given in [this diagram][db-model].

[db-model]: https://gitlab.oceanshq.com/maritime-coastguard-agency/vrsapp/uploads/3d089bf206206b2d313ac84eafa8505a/data_model.png

#### Style

[Bootstrap][bootstrap] has been used to theme the internal dashboard.

[bootstrap]: https://getbootstrap.com/

#### Registration

The registration form currently consists of a number of steps which are
navigated by the user in the following order:

  1. `prerequisites`
  2. `vessel_info`
  3. `owner_info`
  4. `delivery_address`
  5. `declaration`
  6. `payment`

A form object for each step can be found in the `app/forms` directory, whilst
associated controllers are in the `app/controllers/registration` directory, and
form views are in the corresponding subdirectories of `app/views/registration`.

As the user completes each step, the form data is validated according to the
specific validations associated to the form object, and stored in a cookie in
the user's browser. The data is only saved in the database after the final step.

#### Translations

Translations can be found in the locale files.  In particular:

  * `config/locales/en.yml` contains some standard text for the app, as well as
    the translations for the submission buttons on the registration form,
  * `config/locales/simple_form.en.yml` contains translations for the labels,
    prompts and placeholders associated with the fields in each step of the
    registration form,
  * `config/locales/registration/*.en.yml` contains translations for the
    validation error messages, and page title and prompt, for each of the steps
    in the registration form.

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
