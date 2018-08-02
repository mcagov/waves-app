require "rails_helper"

feature "User filters task lists", type: :feature, js: true do
  scenario "part 3" do
    standard =
      create(:unclaimed_task).submission.vessel.name
    premium =
      create(:unclaimed_task, :premium).submission.vessel.name

    login_to_part_3
    click_link("Unclaimed Tasks")

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
end

def filter_service_level
  "#filter_service_level"
end
