require "rails_helper"

describe "User searches" do
  before do
    create(:submission, ref_no: "ABC456")
    create(:submission, ref_no: "ABC123")

    login_to_part_3
  end

  scenario "searching by part of the submission ref_no" do
    search_for("ABC")

    within("#search_results") do
      expect(page).to have_css("tr.submission", count: 2)
    end
  end

  scenario "nothing found" do
    search_for("foo")
    expect(page).to have_text("Nothing found")
  end

  scenario "searching by vessel mmsi"
end

def search_for(term)
  find("input#search").set(term)
  click_on("Go!")
end
