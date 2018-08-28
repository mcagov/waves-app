require "rails_helper"

describe "User starts a manual override task" do
  before do
    Service.create(
      name: "Manual Override",
      standard_days: 1,
      part_1: { standard: 0 },
      part_2: { standard: 0 },
      part_3: { standard: 0 },
      part_4: { standard: 0 },
      rules: [
        :registered_vessel_required,
        :not_referrable,
      ],
      activities: [
        :update_registry_details,
        :record_transcript_event,
      ],
      print_templates: [])
  end

  scenario "in general" do
    visit_registered_vessel

    click_on("Registrar Tools")
    click_on("Manual Override")

    expect(page).to have_css("h1", text: "Manual Override")
    expect(Submission::Task.last).to be_claimed
  end

  scenario "with an open application for that vessel" do
    vessel = create(:submission, :part_3_vessel).registered_vessel
    login_to_part_3
    visit vessel_path(vessel)

    click_on("Registrar Tools")
    click_on("Manual Override")

    expect(page).to have_css("h1", text: "Manual Override")
    expect(Submission::Task.last).to be_claimed
  end
end
