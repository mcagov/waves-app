require "rails_helper"

describe "Team leaders edits an official no", type: :feature, js: true do
  scenario "as a team leader" do
    create(:registered_vessel, reg_no: "DUPLICATE")
    visit_registered_vessel(create(:system_manager))

    click_on("Registrar Tools")
    find(edit_official_number_link).trigger("click")

    within("#edit-official-no") do
      find(".submit_edit_official_no").trigger("click")
    end
  end

  scenario "as an operational user" do
    visit_registered_vessel

    click_on("Registrar Tools")
    expect(page).not_to have_css(edit_official_number_link)
  end
end

def edit_official_number_link
  "#edit_official_number_link"
end
