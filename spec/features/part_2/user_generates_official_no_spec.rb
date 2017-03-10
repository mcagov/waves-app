require "rails_helper"

describe "User generates an official no" do
  scenario "in general" do
    visit_name_approved_part_2_submission

    within("#summary .official-no") do
      click_on("Generate Official No.")
    end

    vessel_reg_no = Submission.last.vessel_reg_no

    within("#summary .official-no") do
      expect(page).to have_text(vessel_reg_no)
    end

    within("#summary .ec-no") do
      expect(page).to have_text("GBR000#{vessel_reg_no}")
    end
  end
end
