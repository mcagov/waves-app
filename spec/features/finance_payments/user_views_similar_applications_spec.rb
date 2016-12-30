require "rails_helper"

describe "User views similar applications for a finance_payment",
         type: :feature, js: true do

  before do
    create(:registered_vessel, reg_no: "SSR200000")
    create(:finance_payment, task: :change_vessel, vessel_reg_no: "SSR200000")
  end

  scenario "with similar applications" do
    suggested_submission =
      create(:assigned_submission,
             task: :change_owner, vessel_reg_no: "SSR200000")

    claim_submission_and_visit

    within("#similar-applications") do
      expect(page)
        .to have_link(
          "Change of Ownership", href: submission_path(suggested_submission))
    end
  end

  scenario "with no similar applications" do
    claim_submission_and_visit

    within("#similar-applications") do
      expect(page).to have_text("No Linked Applications")
    end
  end
end
