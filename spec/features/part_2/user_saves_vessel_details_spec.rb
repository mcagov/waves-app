require "rails_helper"

describe "User save vessel details", js: :true do
  scenario "in general" do
    submission =
      create(
        :name_approval,
        submission: create(:submission, part: :part_2)).submission

    visit_claimed_task(
      submission: submission,
      service: create(:service, :update_registry_details))

    fill_in("Gross Tonnage", with: "1000")
    fill_in("Name of Builder", with: "BOB BUILDS STUFF")
    fill_in("Year of Build", with: "1984")
    select("Bureau Veritas", from: "Classification Society")

    click_on("Save Details")

    expect(page)
      .to have_link("Go to Task List", href: tasks_my_tasks_path)

    click_on("Save to Unclaimed Tasks")

    expect(page).to have_current_path(tasks_my_tasks_path)
    expect(Submission::Task.last).to be_unclaimed
  end

  scenario "for existing vessel, attribute changes have class has-changed" do
    visit_claimed_task(
      submission: create(:submission, :part_2_vessel),
      service: create(:service, :update_registry_details))

    fill_in("Gross Tonnage", with: "1000")
    click_on("Save Details")

    visit submission_path(Submission.last)

    expect(page).to have_css(".has-changed", text: "Gross Tonnage")
  end
end
