require "rails_helper"

feature "User views new submission", type: :feature, js: true do
  let!(:submission) { create_paid_submission! }

  before do
    login
    click_on submission.vessel_info[:name]
  end

  scenario "heading" do
    within("h1") do
      expect(page).to have_content("New Submission")
    end
  end

  scenario "vessel info" do
    within(".submission") do
      expect(page).to have_content(submission.vessel_info[:name])
      expect(page).to have_content(submission.vessel_info[:hin])
      expect(page).to have_content(submission.vessel_info[:make_and_model])
      expect(page).to have_content(submission.vessel_info[:length_in_meters])
      expect(page).to have_content(submission.vessel_info[:number_of_hulls])
      expect(page).to have_content(submission.vessel_info[:vessel_type])
      expect(page).to have_content(submission.vessel_info[:mmsi_number])
    end
  end

  scenario "owner info", javascript: true do
    click_link("Owners")

    within("#owner_1") do
      expect(page).to have_css('th', text: "Owner #1")
      expect(page).to have_css('.owner-name', text: "Horatio Nelson")
      expect(page).to have_css('.declaration', text: "Completed online")
      expect(page).to have_css('.payment', text: "Registered Country of Credit Card: GB")
    end

    within("#owner_2") do
      expect(page).to have_css('th', text: "Owner #2")
      expect(page).to have_css('.owner-name', text: "Edward McCallister")
    end
  end

  scenario "declaration status"
end
