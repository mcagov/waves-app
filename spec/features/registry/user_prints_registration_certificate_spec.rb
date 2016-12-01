require "rails_helper"

describe "User prints a registration certificate", type: :feature, js: true do
  scenario "in general" do
    visit_registered_vessel

    click_on("Registrar Tools")

    pdf_window = window_opened_by do
      click_on("Print Certificate of Registry")
    end

    within_window(pdf_window) do
      expect(page).to have_text("%PDF")
    end
  end
end
