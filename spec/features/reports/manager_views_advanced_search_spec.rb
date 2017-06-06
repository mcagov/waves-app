require "rails_helper"

describe "Manager views advanced search", js: true do
  scenario "in general" do
    login_to_reports
    click_on("Advanced Search")
  end
end
