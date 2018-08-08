require "rails_helper"

describe "User completes a task" do
  scenario "in general" do
    visit_claimed_task

    click_on("Complete Task")
  end
end
