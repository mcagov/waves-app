require "rails_helper"

describe "User save owner details", js: :true do
  scenario "in general" do
    visit_name_approved_part_2_submission
    click_on("Owners & Shareholding")
  end
end
