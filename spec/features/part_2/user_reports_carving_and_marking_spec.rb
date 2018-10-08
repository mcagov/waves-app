require "rails_helper"

describe "User reports receipt of a Carving & Marking Note", js: true do
  scenario "in general" do
    visit_claimed_task(
      submission: create(:name_approval).submission,
      service: create(:demo_service, :update_registry_details))

    click_on("Certificates & Documents")

    within("#carving_and_marking .status") do
      click_on("Mark as Received")
    end

    within("#carving_and_marking .status") do
      click_on("Mark as Pending")
    end

    within("#carving_and_marking .status") do
      expect(page).to have_link("Mark as Received")
    end
  end
end
