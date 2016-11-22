require "rails_helper"

feature "User adds documents to a submission", type: :feature, js: true do
  scenario "in general" do
    visit_assigned_submission
    click_on("Documents")
  end
end
