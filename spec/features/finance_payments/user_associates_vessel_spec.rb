require "rails_helper"

describe "User associates vessel to finance_payment",
         type: :feature, js: true do

  scenario "changing the Offical No. for a change_vessel submission" do
    create(:registered_vessel, reg_no: "SSR200000")
    create(:registered_vessel, reg_no: "SSR244444", name: "FOOBAR")

    create(:finance_payment, task: :change_vessel, vessel_reg_no: "SSR200000")

    claim_submission_and_visit

    within("#finance_info .official_no") do
      click_on("Change")
    end

    within("#change-vessel") do
      search_for("foo")
      within("#vessels") { click_on("Link") }
    end

    within("#finance_info") do
      expect(page).to have_css(".official_no", text: "SSR244444")
    end
  end

  scenario "hiding the Official No. for a new_registration submission" do
    create(:finance_payment, task: :new_registration)

    claim_submission_and_visit

    within("#finance_info") do
      expect(page).to have_css(".official_no", text: "N/A")
    end
  end

  scenario "disabling the Convert button when there is no vessel_reg_no" do
    create(:finance_payment, task: :change_vessel)

    claim_submission_and_visit

    expect(page).to have_css("a.disabled")
  end
end
