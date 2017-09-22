require "rails_helper"

feature "User approves a 'Simple to Full' task", type: :feature, js: :true do
  before do
    @submission = create(:fishing_submission)

    login_to_part_2(@submission.claimant)
    visit(submission_path(@submission))
  end

  scenario "in general" do
    select("Full", from: "Registration Type")
  end
end
