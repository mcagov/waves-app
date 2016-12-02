require "rails_helper"

describe "User freezes (and unfreezes) a vessel", type: :feature, js: true do
  scenario "and unfreezes it" do
    visit_registered_vessel

    click_on("Registrar Tools")
    click_on("Freeze Record")

    expect(page)
      .to have_css("#registration_status .label-danger", text: "Frozen")

    click_on("Registrar Tools")
    click_on("Unfreeze Record")

    expect(page)
      .to have_css("#registration_status .label-success", text: "Registered")
  end
end
