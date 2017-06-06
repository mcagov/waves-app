require "rails_helper"

describe "User adds line items for a submission", js: true do
  scenario "in general" do
    create(:fee)
    visit_assigned_submission

    expect(page).to have_css("#fees #balance", text: "£25.00")

    within(".task_variant") { click_on("New Registration") }

    expect(page).to have_css("#fees #balance", text: "£0.00")

    within(".line_item") do
      expect(page).to have_css(".description", text: "New Registration")
      expect(page).to have_css(".li-price", text: "£25.00")
      expect(page).to have_css(".premium", text: "£0.00")
      click_on("Edit")
    end

    within(".modal-content") do
      fill_in("Standard Fee", with: "12")
      fill_in("Premium Addon", with: "50")
      click_on("Save")
    end

    expect(page).to have_css("#fees #balance", text: "£-37.00")

    within(".line_item") do
      expect(page).to have_css(".li-price", text: "£12.00")
      expect(page).to have_css(".premium", text: "£50.00")
      click_on("Edit")
    end

    within(".modal-content") do
      click_on("Remove")
    end

    expect(page).to have_css("#fees #balance", text: "£25.00")
    expect(page).not_to have_css(".line_item")
  end
end
