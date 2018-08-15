require "rails_helper"

describe "User issues CSR", js: true do
  before do
    visit_claimed_task(
      submission: create(:submission, :part_1_vessel),
      service: create(:demo_service, :issues_csr))
  end

  scenario "save details with the Save Details button" do
    expect(find("#csr_form_issue_number").value).to eq("1")
    expect(find("#csr_form_vessel_name").value).to match(/Registered Boat.*/)
    find("#csr_form_remarks").set("NO COMMENT")
    click_on("Save Details")

    expect(page)
      .to have_link("Go to Task List", href: tasks_my_tasks_path)

    expect(Submission.last.csr_form.remarks).to eq("NO COMMENT")
  end

  xscenario "save details with the Complete Task button" do
    find("#csr_form_remarks").set("NO COMMENT")
    click_on("Complete Task")

    expect(page).to have_css(".modal-title", text: "Task: Demo Service")
    expect(Submission.last.csr_form.remarks).to eq("NO COMMENT")
  end

  xscenario "pending implementation" do
    click_on("Complete Task")
    within("modal.fade.in") { click_on("Complete Task") }

    pdf_window = window_opened_by do
      click_on("Print CSR")
    end

    within_window(pdf_window) do
      expect(page).to have_text("%PDF")
    end

    visit "/print_queue/csr_form"
    expect(page).to have_link("Re-Print")
  end
end
