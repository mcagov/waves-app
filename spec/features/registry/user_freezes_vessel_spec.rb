require "rails_helper"

describe "User freezes (and unfreezes) a vessel", type: :feature, js: true do
  scenario "and unfreezes it" do
    visit_registered_vessel

    click_on("Registrar Tools")
    click_on("Freeze Record")

    within("#freeze-record") do
      fill_in("Reason", with: "Because Alice said....")
      find(:css, ".submit_freeze_record").trigger("click")
    end

    expect(page)
      .to have_css(".registration_status", text: "Frozen")

    click_on("Notes")
    within("#notes") do
      expect(page).to have_text("Because Alice said....")
    end

    click_on("Registrar Tools")
    click_on("Unfreeze Record")

    within("#unfreeze-record") do
      fill_in("Reason", with: "Because Bob said....")
      find(:css, ".submit_unfreeze_record").trigger("click")
    end

    click_on("Notes")
    within("#notes") do
      expect(page).to have_text("Because Bob said....")
    end

    expect(page)
      .to have_css(".registration_status", text: "Registered")
  end

  scenario "when the vessel was frozen due to a section notice" do
    login_to_part_3
    vessel = create(:registered_vessel)
    vessel.issue_section_notice!
    vessel.update_attribute(:frozen_at, Time.zone.now)
    visit vessel_path(vessel)

    click_on("Registrar Tools")
    click_on("Unfreeze Record")

    within("#unfreeze-record") do
      find(:css, ".submit_unfreeze_record").trigger("click")
    end

    expect(page)
      .to have_css(".registration_status", text: "Registered")

    expect(vessel.reload.current_state).to eq(:active)
  end
end
