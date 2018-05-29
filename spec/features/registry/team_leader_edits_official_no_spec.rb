require "rails_helper"

describe "Team leaders edits an official no", type: :feature, js: true do
  scenario "as a team leader" do
    create(:registered_vessel, reg_no: "DUPLICATE")
    visit_registered_vessel(create(:team_leader))

    click_on("Registrar Tools")
    within(".modal-content") do
      click_on("Edit Official Number (Team Leader only)")
    end

    within("#edit-official-no") do
      fill_in("New Official Number", with: "DUPLICATE")
      page.accept_alert do
        find(".submit_edit_official_no").trigger("click")
      end
    end

    within("#edit-official-no") do
      fill_in("New Official Number", with: "NEW001")
      find(".submit_edit_official_no").trigger("click")
    end

    within("#vessel_summary") do
      expect(page).to have_text("Official Number: NEW001")
    end
  end

  scenario "as an operational user" do
    visit_registered_vessel

    click_on("Registrar Tools")
    within(".modal-content") do
      expect(page).not_to have_text(edit_official_number_link)
    end
  end
end

def edit_official_number_link
  "Edit Official Number (Team Leader only)"
end
