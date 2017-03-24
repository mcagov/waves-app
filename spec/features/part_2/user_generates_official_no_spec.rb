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
end
