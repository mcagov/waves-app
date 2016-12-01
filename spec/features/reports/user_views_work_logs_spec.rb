require "rails_helper"

describe "User views work logs", type: :feature do
  xscenario "in general" do
    3.times { create(:work_log) }
    login_to_part_3

    visit reports_work_logs_path

    within("#work_logs") do
      expect(page).to have_css(".description", count: 3)
    end
  end
end
