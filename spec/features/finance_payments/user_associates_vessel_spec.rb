require "rails_helper"

describe "User associates vessel to finance_payment",
         type: :feature, js: true do

  scenario "hiding the Official No. for a change_vessel submission" do
    create(:finance_payment, task: :new_registration)

    claim_submission_and_visit

    within("#finance_info") do
      expect(page).to have_css(".official_no", text: "N/A")
    end
  end
end
