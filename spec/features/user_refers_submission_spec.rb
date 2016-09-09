require "rails_helper"

feature "User refers a submission", type: :feature, js: true do
  before do
    visit_assigned_submission
  end

  scenario "and restores it" do
    within("#actions") { click_on "Refer Application" }

    fill_in "Due By", with: "12/12/2020"
    select "Unknown vessel type", from: "Reason for Referral"
    fill_in "Additional Information", with: "Some stuff"

    within("#refer-application") { click_on "Refer Application" }

    click_on "Referred Applications"
    click_on("Celebrator Doppelbock")

    within("#prompt") do
      expect(page).to have_text(referral_prompt)
    end

    click_on "Reclaim Referral"

    click_on "My Tasks"
    expect(page).to have_css(".vessel-name", text: "Celebrator Doppelbock")
  end

  def referral_prompt
    # rubocop:disable all
    /Application Referred by.*: Unknown vessel type\. Some stuff\. Next action due by 12\/12\/2020\./
    # rubocop:enable all
  end
end
