require "rails_helper"

describe "User views work logs", type: :feature do
  scenario "in general" do
    3.times { create(:work_log) }
    login_to_reports

    visit work_logs_path
    expect(page).to have_css("#work_logs tbody tr", count: 3)
  end
end
