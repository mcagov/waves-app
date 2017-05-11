require "rails_helper"

describe "User views other open submissions" do
  before do
    @vessel = create(:registered_vessel)

    @other_open_submission =
      create(:unassigned_change_vessel_submission,
             vessel_reg_no: @vessel.reg_no)

    @current_submission =
      create(:assigned_change_vessel_submission,
             vessel_reg_no: @vessel.reg_no)

    login_to_part_3(@current_submission.claimant)
    visit submission_path(@current_submission)
  end

  scenario "in general" do
    within("#other-open-tasks") do
      expect(page).to have_text("Change of Vessel details (unclaimed)")

      expect(page).to have_link(
        "Change of Vessel details",
        href: submission_path(@other_open_submission))
    end
  end
end
