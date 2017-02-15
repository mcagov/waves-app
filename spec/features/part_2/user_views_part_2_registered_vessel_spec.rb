require "rails_helper"

describe "User views Part 2 registered vessel", type: :feature, js: true do
  before do
    @submission = create(:completed_submission, part: :part_2)
    @vessel = @submission.registered_vessel
    login_to_part_2
    visit vessel_path(@vessel)
  end

  scenario "tabs" do
    click_on("Vessel Information")
    expect(page).to have_css("li.active a#vessel-tab")

    click_on("Engines")
    expect(page).to have_css("li.active a#engines-tab")

    click_on("Owners & Shareholding")
    expect(page).to have_css("li.active a#owners-tab")

    click_on("Mortgages")
    expect(page).to have_css("li.active a#mortgages-tab")

    click_on("Certificates & Documents")
    expect(page).to have_css("li.active a#certificates-tab")

    click_on("Owners & Shareholding")
    expect(page).to have_css("li.active a#owners-tab")

    click_on("Agents & Representative Persons")
    expect(page).to have_css("li.active a#agents-tab")

    click_on("Applications")
    expect(page).to have_css("li.active a#applications-tab")

    click_on("History")
    expect(page).to have_css("li.active a#history-tab")

    click_on("Correspondence")
    expect(page).to have_css("li.active a#correspondence-tab")

    click_on("Notes")
    expect(page).to have_css("li.active a#notes-tab")
  end
end
