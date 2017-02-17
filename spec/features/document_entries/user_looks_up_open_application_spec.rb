require "rails_helper"

describe "User looks up an open application", js: true do
  before do
    @submission = create(:submission)
    login_to_part_3
    click_on("Document Entry")
  end

  scenario "searching for an open application" do
    within(".modal#start-new-application") do
      click_on("Search for Open Application")
    end

    within(".modal#search-for-submission") do
      search_for(@submission.ref_no)
      within("#submissions") { click_on("View this Application") }
    end
  end
end
