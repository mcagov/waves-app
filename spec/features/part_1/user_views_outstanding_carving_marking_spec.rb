require "rails_helper"

describe "User views and updates outstanding C&M notes", js: true do
  let!(:submission) do
    create(:submission,
           part: :part_1,
           carving_and_marking_received_at: nil,
           carving_and_marking_receipt_skipped_at: 1.week.ago)
  end

  before do
    login_to_part_1
    visit "/part_1/work_logs/"

    click_on("Outstanding Carving & Marking Notes")
  end

  scenario "in general" do
    within("#outstanding_cm") do
      expect(page).to have_text(submission.ref_no)
      click_on("Mark as Received")
    end

    expect(page).to have_text("has been marked as received")
    expect(page).to have_text("There are no outstanding")
  end
end
