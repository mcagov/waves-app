require "rails_helper"

describe "User views and updates outstanding C&M notes", js: true do
  let!(:submission) do
    create(:submission,
           part: :part_1,
           carving_and_marking_received_at: nil,
           carving_and_marking_receipt_skipped_at: 1.week.ago)
  end

  before do
    create(:carving_and_marking, submission: submission)
    create(:completed_task, submission: submission)
    login_to_part_1
    visit "/part_1/work_logs/"

    click_on("Outstanding Carving & Marking Notes")
  end

  scenario "in general" do
    within("#outstanding_cm") { click_on(submission.ref_no) }

    click_on(mark_outstanding_as_received)
    expect(page).to have_text("has been marked as received")
    expect(page).not_to have_link(mark_outstanding_as_received)

    visit outstanding_carving_and_markings_path
    expect(page).to have_text("There are no outstanding")
  end
end

def mark_outstanding_as_received
  "Mark Outstanding Carving & Marking Note as Received"
end
