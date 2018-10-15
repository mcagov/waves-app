require "rails_helper"

describe "User issues a 30 day section notice", type: :feature, js: true do
  scenario "in general" do
    visit_registered_vessel
    @vessel = Register::Vessel.last

    click_on("Registrar Tools")
    click_on(issue_section_notice)

    within(".modal.fade.in") do
      select("56(1)(b)", from: "Regulation/Reason")
      fill_in("Evidence required", with: "Some evidence")

      owner_link = "#section_notice_recipients_#{@vessel.owners.first.id}"
      find(:css, owner_link).trigger("click")
      agent_link = "#section_notice_recipients_#{@vessel.agent.id}"
      find(:css, agent_link).trigger("click")

      find(:css, ".submit_issue_section_notice").trigger("click")
    end

    expect(page).to have_css(".red", text: "Section Notice has been issued")

    click_on("Registrar Tools")
    expect(page).not_to have_link(issue_section_notice)
    find(".close").trigger("click")

    click_on("Correspondence")
    click_on("56(1)(b)")

    within(".modal.fade.in") do
      expect(page).to have_css("h4", text: "Section Notice")
      expect(page).to have_text("Some evidence")
    end

    pdf_window = window_opened_by do
      click_on("Print 30 Day Section Notice")
    end

    within_window(pdf_window) do
      expect(page).to have_text("%PDF")
    end
  end
end

def issue_section_notice
  "Issue 30 Day Section Notice"
end
