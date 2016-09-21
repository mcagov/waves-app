require "rails_helper"

feature "User views new submission", type: :feature, js: true do
  let!(:submission) { create_unassigned_submission! }

  before do
    login_to_part_3
    click_link "Unclaimed Tasks"
    click_on submission.vessel.name
  end

  scenario "heading" do
    within("h1") do
      expect(page).to have_content("New Registration ID: ")
    end
  end

  scenario "payment info", javascript: true do
    click_link("Payment")

    within("#payment") do
      expect(page).to have_text("Worldpay Order Code")
    end
  end

  scenario "history", javascript: true do
    click_link("History")

    within("#history") do
      expect(page).to have_text("Application started")
    end
  end

  scenario "not viewing the action buttons as this is unassigned" do
    expect(page)
      .not_to have_css(
        "a", text: "Register Vessel & Issue Certificate of Registry"
      )
  end
end
