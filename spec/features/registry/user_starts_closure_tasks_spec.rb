require "rails_helper"

describe "User starts task to close registration", type: :feature, js: true do
  before do
    Service.create(
      name: "Registration Closure: Owner Request",
      standard_days: 1,
      part_1: { standard: 0 },
      part_2: { standard: 0 },
      part_3: { standard: 0 },
      part_4: { standard: 0 })

    Service.create(
      name: "Registration Closure: Close Without Notice",
      standard_days: 1,
      part_1: { standard: 0 },
      part_2: { standard: 0 },
      part_3: { standard: 0 },
      part_4: { standard: 0 })
  end

  scenario "By Owner Request" do
    visit_registered_vessel

    click_on("Registrar Tools")
    click_on("Registration Closure: Owner Request")

    expect(page)
      .to have_css("h1", text: "Registration Closure: Owner Request")
  end

  scenario "Without Notice" do
    visit_registered_vessel

    click_on("Registrar Tools")
    click_on("Registration Closure: Close Without Notice")

    expect(page)
      .to have_css("h1", text: "Registration Closure: Close Without Notice")
  end
end
