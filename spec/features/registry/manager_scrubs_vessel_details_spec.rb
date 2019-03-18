require "rails_helper"

describe "System Manager scrubs vessel details", type: :feature, js: true do
  scenario "in general" do
    manager = create(:system_manager)
    visit_registered_vessel(manager)

    click_on("Registrar Tools")
    within(".modal-content") do
      click_on(scrub_vessel_details_link)
    end

    within("#scrub-vessel-details") do
      fill_in(
        "enter the official number",
        with: Register::Vessel.last.reg_no)

      find(".submit_scrub_vessel_details").trigger("click")
    end

    expect(page).to have_text("The personal details have been removed")

    within("label.red") do
      expect(page).to have_text(
        "Personal details were removed by #{manager.name}")
    end
  end

  scenario "when the confirmation text is invalid" do
    manager = create(:system_manager)
    visit_registered_vessel(manager)

    click_on("Registrar Tools")
    within(".modal-content") do
      click_on(scrub_vessel_details_link)
    end

    # with the matching reg_no
    within("#scrub-vessel-details") do
      fill_in(
        "enter the official number",
        with: 123)

      find(".submit_scrub_vessel_details").trigger("click")
    end

    expect(page).to have_text("No action was performed")
  end

  scenario "as an operational user" do
    visit_registered_vessel

    click_on("Registrar Tools")
    within(".modal-content") do
      expect(page).not_to have_text(scrub_vessel_details_link)
    end
  end
end

def scrub_vessel_details_link
  "Remove Personal Details (System Manager only)"
end
