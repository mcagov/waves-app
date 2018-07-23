require "rails_helper"

feature "User views unclaimed task list", type: :feature, js: true do
  let!(:submission_task) { create(:unclaimed_submission_task) }
  let(:submission) { submission_task.submission }

  scenario "viewing the unclaimed tasks" do
    login_to_part_3
    click_link("Unclaimed Tasks")

    within("#tasks") do
      expect(page)
        .to have_css(".vessel-name", text: submission.vessel.name)
      expect(page).to have_content("Demo Service")
      expect(page).to have_content(submission_task.ref_no)
      expect(page).to have_content("10 days away")
    end
  end

  scenario "viewing other parts of the registry" do
    login_to_part_1
    click_link("Unclaimed Tasks")

    expect(page).to have_content("There are no items in this queue")
  end

  xscenario "filtering unclaimed tasks" do
    pleasure = create(:unassigned_pleasure_submission).vessel.name
    commercial = create(:unassigned_commercial_submission).vessel.name
    not_set = create(:unassigned_no_reg_type_submission).vessel.name

    login_to_part_1
    click_link("Unclaimed Tasks")

    expect(page).to have_css("td.vessel-name", text: pleasure)
    expect(page).to have_css("td.vessel-name", text: commercial)
    expect(page).to have_css("td.vessel-name", text: not_set)

    select("Pleasure", from: "Registration Type")
    click_on("Filter")
    expect(page).to have_css("td.vessel-name", text: pleasure)
    expect(page).to have_css("td.vessel-name", count: 1)

    select("Commercial", from: "Registration Type")
    click_on("Filter")
    expect(page).to have_css("td.vessel-name", text: commercial)
    expect(page).to have_css("td.vessel-name", count: 1)

    select("Not set", from: "Registration Type")
    click_on("Filter")
    expect(page).to have_css("td.vessel-name", text: not_set)
    expect(page).to have_css("td.vessel-name", count: 1)
  end
end
