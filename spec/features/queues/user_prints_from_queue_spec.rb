require "rails_helper"

describe "User prints from queue", type: :feature, js: true do
  before do
    @template = :registration_certificate

    registration =
      create(:registration,
             registry_info: create(:registered_vessel).registry_info)

    create(:print_job, template: @template, printable: registration)

    login_to_part_3
    visit print_jobs_path(template: @template)
  end

  scenario "printing all certificates" do
    expect(page)
      .to have_css("h1", text: "Print Queue: Certificates of Registry")

    pdf_window = window_opened_by do
      click_on("Print Certificates of Registry")
    end

    within_window(pdf_window) do
      expect(page).to have_text("%PDF")
    end

    visit print_jobs_path(template: @template)
    expect(page).to have_content("There are no items in this queue")
  end

  scenario "printing a single item" do
    pdf_window = window_opened_by do
      within("td.certificate") { click_on("Print") }
    end

    within_window(pdf_window) do
      expect(page).to have_text("%PDF")
    end
  end

  scenario "when viewing another part of the registry" do
    login_to_part_1
    visit print_jobs_path(template: @template)

    expect(page).to have_content("There are no items in this queue")
  end
end
