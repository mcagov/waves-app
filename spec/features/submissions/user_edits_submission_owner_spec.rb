require "rails_helper"

feature "User views Owner submission details", type: :feature, js: true do
  before { visit_assigned_submission }

  scenario "in general" do
    owner = Declaration.last.owner

    click_on("Owners")
    expect(page).to have_css("table#declaration_1 th", count: 2)

    expect(page).to have_css(".owner-name", text: owner.name)
    expect(page).to have_css(".owner-email", text: owner.email)
    expect(page).to have_css(".owner-nationality", text: owner.nationality)
    expect(page).to have_css(".owner-address", text: owner.inline_address)
  end
end
