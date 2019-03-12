require "rails_helper"

describe "User issues a Carving & Marking Note", js: true do
  scenario "by email" do
    visit_claimed_task(
      submission: create(:submission, :part_2_vessel),
      service: create(:service, :carving_and_marking_required))

    click_on("Certificates & Documents")

    within("#carving_and_marking .status") do
      click_on("Email")
    end

    within(".modal-content") do
      check(@submission.owners.first.name)
      check(@submission.applicant_name)
      fill_in("Subject", with: "Carving & Marking Subject")
      select("All fishing vessels", from: "Print Template")
      find("#carving_and_marking_modal_trix_input", visible: false)
        .set("C&M, please!")

      click_on("Issue Carving & Marking Note")
    end

    expect(page).to have_text("Carving and Marking Note has been issued")

    click_on("Certificates & Documents")
    within("#carving_and_marking") do
      expect(page).to have_css(".delivery_method", text: "Email")
    end

    click_on("Correspondence")
    expect(page)
      .to have_css("#notification-list", text: "Carving & Marking Subject")

    creates_a_work_log_entry(:carving_and_marking_issued)
    expect(Notification::CarvingAndMarkingNote.count).to eq(2)
  end

  scenario "when no recipient is selected, a note is not issued" do
    visit_claimed_task(
      submission: create(:submission, :part_2_vessel),
      service: create(:service, :carving_and_marking_required))

    click_on("Certificates & Documents")

    within("#carving_and_marking .status") do
      click_on("Email")
    end

    within(".modal-content") do
      click_on("Issue Carving & Marking Note")
    end

    expect(page).to have_text("Recipient(s) must be selected")
    expect(Notification::CarvingAndMarkingNote.count).to eq(0)
    expect(CarvingAndMarking.count).to eq(0)
  end

  scenario "as a printed page" do
    visit_claimed_task(
      submission: create(:submission, :part_2_vessel),
      service: create(:service, :carving_and_marking_required))

    click_on("Certificates & Documents")

    within("#carving_and_marking .status") do
      click_on("Print")
    end

    within(".modal-content") do
      select("All fishing vessels", from: "Template")
      click_on("Issue Carving & Marking Note")
    end

    expect(page).to have_text("Carving and Marking Note has been issued")

    click_on("Certificates & Documents")
    pdf_window = window_opened_by { click_on("Print Carving & Marking Note") }
    within_window(pdf_window) { expect(page).to have_text("%PDF") }

    expect(PrintJob.last).to be_printing
    expect(Notification::CarvingAndMarkingNote.count).to eq(0)
  end

  scenario "when the pre-requisites have not been met (no vessel_reg_no)" do
    visit_claimed_task(
      submission: create(:name_approval).submission,
      service: create(:service, :carving_and_marking_required))

    click_on("Certificates & Documents")

    within("#carving_and_marking .status") do
      expect(page).to have_css(".red", text: "Official Number required")
    end
  end
end
