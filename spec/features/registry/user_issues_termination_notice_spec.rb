require "rails_helper"

describe "User issues a 7 Day Termination Notice", type: :feature, js: true do
  scenario "when a 30 day section notice has been issued" do
    login_to_part_3

    vessel = create(:registered_vessel)
    vessel.issue_section_notice!
    recipient = %w(BOB LONDON)

    section_notice =
      Register::SectionNotice.create(noteable: vessel, recipients: [recipient])
    section_notice
      .update_columns(created_at: 20.days.ago, updated_at: 20.days.ago)

    visit vessel_path(vessel)

    click_on("Registrar Tools")
    click_on(notice_of_termination_link)

    expect(page).to have_css(".red", text: "Termination Notice has been issued")

    click_on("Registrar Tools")
    expect(page).not_to have_link(notice_of_termination_link)
    find(".close").trigger("click")

    click_on("Correspondence")
    click_on("Relates to Section Notice, issued on: ")

    within(".modal.fade.in") do
      expect(page).to have_css("h4", text: "Termination Notice")
      expect(page).to have_text("BOB LONDON")
    end

    pdf_window = window_opened_by do
      click_on("Print 7 Day Notice of Termination")
    end

    within_window(pdf_window) do
      expect(page).to have_text("%PDF")
    end
  end

  scenario "when a 30 day section notice has not been generated" do
    visit_registered_vessel
    click_on("Registrar Tools")
    expect(page).not_to have_link(notice_of_termination_link)
  end
end

def notice_of_termination_link
  "Issue 7 Day Termination Notice"
end
