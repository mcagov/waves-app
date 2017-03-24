require "rails_helper"

describe "User generates an official no", js: true do
  before do
    visit_name_approved_part_2_submission

    within("#summary .official-no") do
      click_on("Generate Official No.")
    end
  end

  scenario "with a system-generated no" do
    within(".modal.fade.in") do
      click_on("Continue")
    end

    within("#summary") do
      vessel_reg_no = Register::Vessel.last.reg_no
      expect(page).to have_css(".official-no", text: vessel_reg_no)
      expect(page).to have_css(".ec-no", text: "GBR000#{vessel_reg_no}")
    end
  end

  scenario "with valid user-input" do
    within(".modal.fade.in") do
      find_field("official_no_content").set("VESSEL_REG_NO")
      click_on("Continue")
    end

    within("#summary") do
      expect(page).to have_css(".official-no", text: "VESSEL_REG_NO")
      expect(page).to have_css(".ec-no", text: "VESSEL_REG_NO")
    end
  end

  scenario "with invalid user-input" do
    within(".modal.fade.in") do
      find_field("official_no_content").set("SSR200001")
      click_on("Continue")
    end

    expect(page)
      .to have_css(".alert", text: "Official Number is not available")
  end
end
