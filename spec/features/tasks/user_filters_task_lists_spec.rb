require "rails_helper"

feature "User filters task lists", type: :feature, js: true do
  scenario "part 3" do
    standard =
      create(:unclaimed_task).submission.vessel.name
    premium =
      create(:unclaimed_task, :premium).submission.vessel.name

    login_to_part_3
    click_link("Unclaimed Tasks")

    expect(page).not_to have_css(filter_registration_type)

    expect(page).to have_css("td.vessel-name", text: standard)
    expect(page).to have_css("td.vessel-name", text: premium)

    find(filter_service_level).set("premium")
    click_button("Filter")

    expect(page).not_to have_css("td.vessel-name", text: standard)
    expect(page).to have_css("td.vessel-name", text: premium)

    find(filter_service_level).set("")
    click_on("Filter")

    expect(page).to have_css("td.vessel-name", text: standard)
    expect(page).to have_css("td.vessel-name", text: premium)
  end

  scenario "part 1" do
    commercial =
      create(
        :unclaimed_task, submission: create(:commercial_part_1_submission)
      ).submission.vessel.name

    high_profile =
      create(
        :unclaimed_task, submission: create(:high_profile_part_1_submission)
      ).submission.vessel.name

    login_to_part_1
    click_link("Unclaimed Tasks")
    expect(page).to have_css(filter_service_level)

    expect(page).to have_css("td.vessel-name", text: commercial)
    expect(page).to have_css("td.vessel-name", text: high_profile)

    find(filter_registration_type).set("high_profile")
    click_button("Filter")

    expect(page).not_to have_css("td.vessel-name", text: commercial)
    expect(page).to have_css("td.vessel-name", text: high_profile)
  end
end

def filter_service_level
  "#filter_service_level"
end

def filter_registration_type
  "#filter_registration_type"
end
