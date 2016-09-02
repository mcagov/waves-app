require "rails_helper"

feature "User views new submission", type: :feature, js: true do
  let!(:submission) { create_paid_submission! }

  before do
    login_to_part_3
    click_on submission.vessel.name
  end

  scenario "heading" do
    within("h1") do
      expect(page).to have_content("New Registration ID: ")
    end
  end

  scenario "vessel" do
    within(".submission") do
      expect(page).to have_content(submission.vessel.name)
      expect(page).to have_content(submission.vessel.hin)
      expect(page).to have_content(submission.vessel.make_and_model)
      expect(page).to have_content(submission.vessel.length_in_meters)
      expect(page).to have_content(submission.vessel.number_of_hulls)
      expect(page).to have_content(submission.vessel.vessel_type)
      expect(page).to have_content(submission.vessel.mmsi_number)
    end
  end

  scenario "owner info", javascript: true do
    click_link("Owners")

    within("#owner_1") do
      expect(page).to have_css("th", text: "Owner #1")
      expect(page).to have_css(".owner-name", text: "Horatio Nelson")
      expect(page).to have_css(".declaration", text: "Completed online")
    end

    within("#owner_2") do
      expect(page).to have_css("th", text: "Owner #2")
      expect(page).to have_css(".owner-name", text: "Edward McCallister")
    end
  end

  scenario "payment info", javascript: true do
    click_link("Payment")

    within("#payment") do
      expect(page).to have_text("Worldpay Order Code")
    end
  end

  scenario "not viewing the action buttons as this is unassigned" do
    expect(page).not_to have_css("a", text: "Register Vessel & Issue Certificate of Registry")
  end

  scenario "declaration made"
end



