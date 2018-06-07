require "rails_helper"

describe "User searches within part 3" do
  before do
    login_to_part_3
  end

  context "by submission" do
    scenario "searching by part of the submission ref_no" do
      create(:submission, ref_no: "ABC456")
      create(:submission, ref_no: "ABC123")

      within(".nav_menu") { search_for("ABC") }

      within("#search_results") do
        expect(page).to have_css("tr.submission", count: 2)
      end
    end

    scenario "searching by owner postcode", js: true do
      create(:submission)

      within(".nav_menu") { search_for("QZ2 3Q") }

      within("#search_results") do
        expect(page).to have_css("tr.submission", count: 1)
      end
    end

    scenario "searching for a submission in another part" do
      create(:fishing_submission, ref_no: "ABC456")

      within(".nav_menu") { search_for("ABC") }
      expect(page).to have_text("Nothing found")
    end

    scenario "nothing found" do
      within(".nav_menu") { search_for("foo") }
      expect(page).to have_text("Nothing found")
    end
  end
end
