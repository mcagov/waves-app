require "rails_helper"

describe "User adds line items for a submission", js: true do
  before do
    create(:fee)
    visit_assigned_submission
  end

  scenario "in general" do
    expect(page).to have_css("#fees #balance", text: "£25.00")

    within(".task_variant") { click_on("New Registration") }

    expect(page).to have_css("#fees #balance", text: "£0.00")

    within(".line_item") do
      expect(page).to have_css(".description", text: "New Registration")
      expect(page).to have_css(".li-price", text: "£25.00")
      click_on("Edit")
    end

    within(".modal-content") do
      fill_in("Standard Fee", with: "12")
      click_on("Save")
    end

    expect(page).to have_css("#fees #balance", text: "£13.00")

    within(".line_item") do
      expect(page).to have_css(".li-price", text: "£12.00")
      click_on("Edit")
    end

    within(".modal-content") do
      click_on("Remove")
    end

    expect(page).to have_css("#fees #balance", text: "£25.00")
    expect(page).not_to have_css(".line_item")
  end
end
