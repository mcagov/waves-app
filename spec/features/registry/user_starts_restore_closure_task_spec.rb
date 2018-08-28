require "rails_helper"

describe "User starts task to restore closure", type: :feature, js: true do
  before do
    Service.create(
      name: "Restore Closed Registration",
      standard_days: 1,
      part_1: { standard: 0 },
      part_2: { standard: 0 },
      part_3: { standard: 0 },
      part_4: { standard: 0 },
      activities: [:restore_closure])
  end

  scenario "in general" do
    visit_closed_vessel

    click_on("Registrar Tools")
    click_on("Restore Closed Registration")

    expect(page)
      .to have_css("h1", text: "Restore Closed Registration")
  end
end
