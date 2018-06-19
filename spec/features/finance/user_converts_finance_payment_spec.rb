require "rails_helper"

describe "User converts finance payment", type: :feature, js: true do
  before do
    create(:locked_finance_payment)
    visit_fee_entry
  end

  scenario "in general" do
    click_on("Convert to Application")

    application_is_saved
  end

  scenario "rendering the :new template after an error" do
    select("Re-Registration", from: "Application Type")
    click_on("Convert to Application")

    select("New Registration", from: "Application Type")
    click_on("Convert to Application")

    application_is_saved
  end
end

def application_is_saved
  expect(page).to have_text("application has been saved")
  expect(page).to have_css("h1", text: "My Tasks")
  expect(Payment::FinancePayment.unattached).to be_empty
end
