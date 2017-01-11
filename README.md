# Waves Internal App

## About

This app currently consists of a vessel submission API and a content
management system. The API is intended to support on the
Gov.UK hosted website as a means for the owner of a (singley owned) small ship to
register their vessel under **Part III of the UK Ships Register**. The content
management system is intended to be a means of managing the register and
workload of officers of the [Maritime and Coastguard Agency][mca].

[mca]: https://www.gov.uk/government/organisations/maritime-and-coastguard-agency

##### Architecture

This is a standard Rails 5.0 web app with a PostgreSQL database.

##### Look & Feel

[Bootstrap][bootstrap] has been used to theme the internal dashboard.

[bootstrap]: https://getbootstrap.com/

#### Setup

To set up a new development environment, follow the steps below:

    bundle install
    cp .env.example .env
    cp config/database.yml.example config/database.yml

Then complete the `.env` file with your environment settings, and complete the
`config/database.yml` file with your database settings.

Setup your databases with:

    bundle exec rake db:setup
    bundle exec rake db:test:prepare

##### Installation issues

If capybara-webkit fails when you run `bundle install`, refer to the [capybara-webkit help page](https://github.com/thoughtbot/capybara-webkit/wiki/Installing-Qt-and-compiling-capybara-webkit)

#### Running the webserver locally

To run the app locally:

    bundle exec rails server

The app will then be available at http://localhost:3000/

##### Testing

We use RSpec for tests. To run the test suite, run:

    bundle exec rspec

If you get the error `DATABASE_URL environment variable is set` you will need to remove the `DATABASE_URL` from the local .env file.

##### API / CORS

We are using the [rack-cors](https://github.com/cyu/rack-cors) gem.

CORS is configured in `config/initalisers/cors.rb` and the origins are defined by `ENV['CORS_ORIGINS']`.

##### Email previews

Emails can be previewed at: /rails/mailers in development.

##### SMS Notification
SMS Notifications are delivered by [Gov.UK Notify](https://www.notifications.service.gov.uk).
This is implemented in `app/services/sms_provider.rb`.
Ensure that the API key is set as `ENV['NOTIFY_API_KEY']`,
And the Template ID as `ENV['NOTIFY_TEMPLATE_ID']`.

##### Cron jobs

Cron jobs are managed with the [whenever](https://github.com/javan/whenever) gem.

To ensure the crontab is kept up to date, ensure that `whenever --update-crontab` is called on deployment.

##### Referred applications

Schedule: Daily

If the `submission#referred_until` date has been reached, applications should be restored to the unclaimed tasks queue. To run this task:

  `rake waves:expire_referrals`


## Under the hood
##### Submissions
Submissions are requests to change something in the Registry of Ships. In the UI, we call them 'Applications' but in the Rails world, 'application' is a reserved word. A submission can be for a variety of different tasks.

The full list of tasks can be retrieved from `Task.all_task_types`. Note that the Task  class is in the WavesUtilities gem.
##### State Machine
Submissions travel through a state machine `app/models/submission/state_machine.rb`. When a submission has reached the `:unassigned` state, it can be claimed by a Registration Officer for processing. When a submission has been claimed (state: `assigned`), it can be `referred`, `cancelled` or `approved`. Business rules apply to the action taken when one of these states is initiated, e.g. sending a notification email, setting the processing target date, creating or updating an entry in the registry.

##### How submissions are created
There are three points of entry for a submission:
1. Via a customer entry on the Online portal (submission#source `:online`)
2. Via a manual entry by the Finance Team (submission#source `:manual_entry`)
3. Via a manual entry by a Registration Officer (submission#source `:manual_entry`)

The initial state of an `:online` entry is `:incomplete`. When payment is completed and all the owners have made their declarations, then it moves to `:unassigned` and can be claimed by a Registration Officer.

When a submission enters the default :incomplete state, it fires an event `build_default`, invoking the `SubmissionBuilder` and setting up all the defaults. If you want to initialize a submission object to build a form or any other instance when you don't want a record to be created, you need to forecfully set the state to :initializing. For example: `Submission.new(state: :initializing)`.

The initial state of a `:manual_entry` is `:unassigned` so that it can be claimed. Note that a submission created by the Finance Team sets the flag `submission#officer_intervention_required` to ensure that the Registration Officer checks the details before they can action it.

##### Submission Behaviour
A submission's behaviour depends on the follwing attributes:
1. The `part` of the Registry (I, II, III or IV)
2. The `source` (`online` or `manual_entry`)
3. The `task` that the submission will perform
4. The `registered_vessel` it belongs to (doesn't apply to new registrations)

##### Submission Attributes
The changes that the submission will perform are stored as JSON objects in submission#changeset. If the submission is associated with a registered vessel, the 'current information' will be stored as JSON objects in submission#changeset.
These JSON objects are mounted with the `VirtualModel` class and exposed by the submission as: `submission.vessel`, etc.

##### Payments
Payments come in two flavours and have a polymorphic association with the `Payment` model.
1. World Pay Payments (online)
2. Finance Payments (manual_entry)

##### Declarations
In the submission context, we store owner details in the declarations table. The changes requested are stored as JSON objects in declaration#changeset. One owner maps to one declaration, and a submission can have many declarations.

##### The Registry
The Registry consists of:
1. Registrations. The record of the current and previous registration details for a vessel.
2. Vessels. The current vessel record.
3. Owners. The current record of vessel owners.

##### Code structure
The app follows the standard Rails MVC pattern, additionally:
1. Builders are used to perform actions that create or update database records.
2. Decorators are used to add UI behaviour to the models.
3. Policies are user to answer questions: 'Can the submission be approved now?'
4. Services are used to encapsulate helper methods that don't make any database changes.

And mixins:
1. Concerns. Tried to limit the use of Active Record Concerns to functionality that was open to all models.
2. Submission mixins. The Submission class was getting too big for rubocop, so `app/model/submission/associations.rb` and  `app/model/submission/state_machine.rb` were extracted to modules. No reason other than code organization. Would welcome smart refactoring.

##### Search
Searching is helped along with [pg_search gem](https://github.com/Casecommons/pg_search).
To rebuild the (e.g. Submission) indexes after making changes to the configuration:
`PgSearch::Multisearch.rebuild(Submission)`
Global search configuration can be added to:
`config/initializers/pg_search.rb`
