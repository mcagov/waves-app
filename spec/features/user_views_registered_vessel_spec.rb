require "rails_helper"

describe "User views a registered vessel", type: :feature, js: true do
  before do
    @submission = create_completed_application!
    login_to_part_3
  end

  scenario "in general" do
    visit vessels_path
    click_on("Celebrator")

    expect(page).to have_css("h1", text: "Celebrator")

    click_on("People")
    expect(page).to have_css(".owner-name", text: "Horatio Nelson")

    click_on("Applications")
    expect(page)
      .to have_link("New Registration", href: submission_path(@submission))
  end
end
