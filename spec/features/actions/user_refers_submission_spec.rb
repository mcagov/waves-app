require "rails_helper"

feature "User refers a submission", type: :feature, js: true do
  before do
    visit_assigned_submission
    @vessel_name = Submission.last.vessel.name
  end

  scenario "and restores it" do
    within("#actions") { click_on "Refer Application" }

    fill_in "Due By", with: "12/12/2020"
    select "Unknown vessel type", from: "Reason for Referral"
    within("#refer-application") { click_on "Refer Application" }

    click_on "Referred Applications"
    click_on @vessel_name

    within("#prompt") do
      expect(page).to have_text(referral_prompt)
    end

    click_button "Reclaim Referral"

    click_on "My Tasks"
    click_on @vessel_name
    click_on "Correspondence"

    within("#notification-list") do
      first(
        "a", text: "Application Referred - Action Required").click
    end
    expect(page).to have_css("h4", text: "Referral Email")
  end

  scenario "without sending an email" do
    within("#actions") { click_on "Refer Application" }
    check("Do not send email to Correspondent")
    within("#refer-application") { click_on "Refer Application" }
  end

  def referral_prompt
    # rubocop:disable all
    /Application Referred by.*: Unknown vessel type\. Next action due by 12\/12\/2020\./
    # rubocop:enable all
  end
end
