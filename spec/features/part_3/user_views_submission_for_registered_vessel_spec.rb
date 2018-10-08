require "rails_helper"

describe "User views submission for a registered vessel" do
  before do
    visit_claimed_task(
      submission: create(:submission, :part_3_vessel),
      service: create(:service, :registered_vessel_required))
  end

  scenario "in general" do
    within(".submission-vessel") do
      expect(page).to have_css("th", text: "Vessel Details")
      expect(page).to have_css("th", text: "Current Information")
      expect(page).to have_css("th", text: "Submitted Information")
    end
  end
end
