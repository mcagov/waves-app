require "rails_helper"

describe "User cancels a Section Notice", type: :feature, js: true do
  scenario "when a 30 day section notice has been issued" do
    login_to_part_3
    vessel = create(:registered_vessel)
    vessel.issue_section_notice!
    Register::SectionNotice.create(noteable: vessel)

    visit vessel_path(vessel)

    click_on("Registrar Tools")
    click_on(cancel_section_notice_link)

    expect(page).to have_text("Section Notice has been cancelled")

    click_on("Notes")
    within("#notes") do
      expect(page).to have_text("Section Notice cancelled")
    end
  end

  scenario "when a 30 day section notice has not been generated" do
    visit_registered_vessel
    click_on("Registrar Tools")
    expect(page).not_to have_link(cancel_section_notice_link)
  end
end

def cancel_section_notice_link
  "Cancel Section Notice"
end
