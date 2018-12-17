require "rails_helper"

describe "System Manager edits registration dates", type: :feature, js: true do
  scenario "as a system manager" do
    visit_registered_vessel(create(:system_manager))

    click_on("Registrar Tools")
    within(".modal-content") do
      click_on(edit_registration_dates_link)
    end

    within("#edit-registration-dates") do
      fill_in("Registration Date", with: "30-07-2018")
      fill_in("Registration Expiry Date", with: "01-08-2023")
      find(".submit_edit_registration_dates").trigger("click")
    end

    expect(page).to have_css(".registered_at", text: "Mon Jul 30, 2018")
    expect(page).to have_css(".registered_until", text: "Tue Aug 01, 2023")
  end

  scenario "as an operational user" do
    visit_registered_vessel

    click_on("Registrar Tools")
    within(".modal-content") do
      expect(page).not_to have_text(edit_registration_dates_link)
    end
  end
end

def edit_registration_dates_link
  "Edit Registration Dates (System Manager only)"
end
