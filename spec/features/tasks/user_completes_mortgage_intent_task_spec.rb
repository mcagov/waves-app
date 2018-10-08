require "rails_helper"

describe "User completes mortgage intent task", js: true do
  before do
    visit_claimed_task(
      service: create(:service, activities: [], rules: []),
      submission: create(:submission, part: :part_1))
  end

  scenario "in general" do
    click_on("Mortgages")
    click_on("Complete Task")
  end
end
