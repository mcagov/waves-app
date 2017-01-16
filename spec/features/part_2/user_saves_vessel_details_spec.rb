require "rails_helper"

describe "User save vessel details", js: :true do
  scenario "in general" do
    visit_name_approved_part_2_submission

    fill_in("Classification Society", with: "CLASSIFICATION")
    fill_in("Gross Tonnage", with: "1000")
    fill_in("Name of Builder", with: "BOB BUILDS STUFF")

    click_on("Save Details")
    expect(page).to have_text("Application details successfully saved.")

    expect(page)
      .to have_link("Continue", href: submission_path(Submission.last))

    expect(page)
      .to have_link("Go to Task List", href: tasks_my_tasks_path)
  end

  scenario "for an existing vessel, attribute changes have class has-changed" do
    visit_part_2_change_vessel_submission

    fill_in("Gross Tonnage", with: "1000")
    click_on("Save Details")
    click_on("Continue")

    expect(page).to have_css(".has-changed", text: "Gross Tonnage")
  end
end
