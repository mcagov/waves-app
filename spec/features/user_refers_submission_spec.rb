require "rails_helper"

feature "User refers a submission", type: :feature, js: true do
  before do
    visit_completeable_submission
  end

  scenario " and does stuff "
end
