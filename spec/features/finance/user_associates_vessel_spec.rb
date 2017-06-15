require "rails_helper"

describe "User associates vessel to finance_payment",
         type: :feature, js: true do

  scenario "changing the Offical No. for a change_vessel submission" do
    vessel_a = create(:registered_vessel)
    vessel_b = create(:registered_vessel, name: "FOOBAR")

    create(:submitted_finance_payment, task: :change_vessel,
                                       vessel_reg_no: vessel_a.reg_no)

    claim_fee_entry_and_visit

    expect(page).to have_css(".official_no", text: vessel_a.reg_no)
    within("#finance_info .official_no") { click_on("Change") }

    within("#change-vessel") do
      search_for("foo")
      within("#vessels") { click_on("Link") }
    end

    within("#finance_info") do
      expect(page).to have_css(".official_no", text: vessel_b.reg_no)
    end
  end

  scenario "hiding the Official No. for a new_registration submission" do
    create(:submitted_finance_payment, task: :new_registration)

    claim_fee_entry_and_visit

    within("#finance_info") do
      expect(page).to have_css(".official_no", text: "N/A")
    end
  end

  scenario "disabling the Convert button when there is no vessel_reg_no" do
    create(:submitted_finance_payment, task: :change_vessel)

    claim_fee_entry_and_visit

    expect(page).to have_css("a.disabled")
  end
end
