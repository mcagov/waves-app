require "rails_helper"

describe "System Manager edits registration dates", type: :feature, js: true do
  scenario "as a system manager" do
    vessel = create(:registered_vessel)
    visit_registered_vessel(create(:system_manager))

    click_on("Registrar Tools")
    within(".modal-content") do
      click_on(edit_registration_dates_link)
    end

    within("#edit-registration-dates") do
      fill_in("Registration Date", with: "30-07-2018")
      fill_in("Registration Expiry Date", with: "01-08-2023")
      page.accept_alert do
        find(".submit_edit_official_no").trigger("click")
      end
    end

    within("#vessel_summary") do
      expect(page).to have_text("Registration Date: Mon July 30, 2018")
      expect(page).to have_text("Registration Expiry Date:  Tue Aug 1, 2023")
    end
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
