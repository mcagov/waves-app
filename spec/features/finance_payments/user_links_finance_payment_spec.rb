require "rails_helper"

describe "User links finance_payment", type: :feature, js: true do
  before do
    create(
      :submission,
      part: :part_3,
      task: :new_registration,
      ref_no: "ABC123")

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

  scenario "to a different application" do
    within("#actions") { click_on("Link to a Different Application") }
  end
end
