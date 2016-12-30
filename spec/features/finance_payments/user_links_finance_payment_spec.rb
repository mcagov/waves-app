require "rails_helper"

describe "User links finance_payment", type: :feature, js: true do
  before do
    create(
      :submission,
      part: :part_3,
      task: :new_registration,
      ref_no: "ABC123")

    create(
      :submission,
      part: :part_3,
      task: :new_registration,
      ref_no: "FOOBAR")

    create(
      :finance_payment,
      part: :part_3,
      task: :new_registration,
      application_ref_no: "ABC123")

    login_to_part_3
    click_on("Unclaimed Tasks")
    click_on("Claim")
    click_on("Process Next Application")
  end

  scenario "to the prompted application" do
    expect(page)
      .to have_css("h1", text: "New Registration ID: Not yet generated")

    within("#actions") { click_on("Link to Application") }

    expect(page).to have_css("h1", text: "New Registration ID: ABC123")
  end

  scenario "to another application" do
    within("#actions") { click_on("Link to Another Application") }

    within("#link-application") do
      search_for("foo")
      within("#submissions") { click_on("Link") }
    end

    expect(page).to have_css("h1", text: "New Registration ID: FOOBAR")
  end
end
