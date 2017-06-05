require "rails_helper"

describe "User adds line items for a submission", js: true do
  before do
    create(:fee)
    visit_assigned_submission
  end

  scenario "in general" do
    within(".task_variant") { click_on("New Registration") }
    expect(page).to have_css(".line_item-description", text: "New Registration")
    expect(page).to have_css(".line_item-price", text: "£25.00")
  end
end
