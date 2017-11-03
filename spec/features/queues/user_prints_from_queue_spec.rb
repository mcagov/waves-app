require "rails_helper"

describe "User prints from queue", type: :feature, js: true do
  before do
    @template = :registration_certificate
    registration = create(:registered_vessel).current_registration
    create(:print_job, template: @template, printable: registration)
  end

  scenario "printing all certificates" do
    login_to_part_3
    visit print_jobs_path(template: @template)

    expect(page)
      .to have_css("h1", text: "Print Queue: Certificates of Registry")

    within("#unprinted") do
      expect(page).to have_css("td", text: "Registered Boat")
    end

    pdf_window = window_opened_by do
      click_on("Print Certificates of Registry")
    end

    within_window(pdf_window) do
      expect(page).to have_text("%PDF")
    end

    visit print_jobs_path(template: @template)

    within("#unprinted") do
      expect(page).to have_content("There are no items in this queue")
    end

    within("#printing") do
      expect(page).to have_css("td", text: "Registered Boat")
    end
  end

  scenario "printing a single item, re-printing, marking as printed" do
    login_to_part_3
    visit print_jobs_path(template: @template)

    pdf_window = window_opened_by do
      within("td.certificate") { click_on("Print") }
    end

    within_window(pdf_window) do
      expect(page).to have_text("%PDF")
    end

    visit print_jobs_path(template: @template)

    pdf_window = window_opened_by do
      within("#printing") { click_on("Re-Print") }
    end

    within_window(pdf_window) do
      expect(page).to have_text("%PDF")
    end

    visit print_jobs_path(template: @template)
    within("#printing") { click_on("Mark as Printed") }

    visit print_jobs_path(template: @template)
    within("#printing") do
      expect(page).to have_content("All items have been marked")
    end
  end

  scenario "when viewing another part of the registry" do
    login_to_part_1
    visit print_jobs_path(template: @template)

    expect(page).to have_content("There are no items in this queue")
  end
end
