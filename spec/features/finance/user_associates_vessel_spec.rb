require "rails_helper"

xdescribe "User associates vessel to finance_payment", type: :feature,
                                                       js: true do
  scenario "changing the Offical No. for a change_vessel submission" do
    vessel_a = create(:registered_vessel)
    vessel_b = create(:registered_vessel, name: "FOOBAR")

    create(:locked_finance_payment, task: :change_vessel,
                                    vessel_reg_no: vessel_a.reg_no)

    visit_fee_entry

    expect(page).to have_css(".official_no", text: vessel_a.reg_no)
    within(".official_no") { click_on("Change") }

    within("#change-vessel") do
      search_for("foo")
      within("#vessels") { click_on("Link") }
    end

    expect(page).to have_css(".official_no", text: vessel_b.reg_no)
  end

  scenario "hiding the Official Number for a new_registration submission" do
    create(:locked_finance_payment, task: :new_registration)

    visit_fee_entry

    expect(page).to have_css(".official_no", text: "N/A")
  end
end
