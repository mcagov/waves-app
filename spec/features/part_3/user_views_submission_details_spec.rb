require "rails_helper"

feature "User views part_3 submission details", type: :feature, js: true do
  let!(:submission) do
    create(:claimed_task,
           submission: create(:submission, :part_3_vessel),
           service: create(:service, :update_registry_details)
          ).submission
  end

  let!(:registered_vessel) { submission.registered_vessel }
  let!(:registered_owner) { registered_vessel.owners.first }
  let!(:declaration) { submission.declarations.first }

  before do
    declaration.owner.name = "NEW OWNER NAME"
    declaration.save!

    login_to_part_3
    visit submission_path(submission)
  end

  scenario "owner tab" do
    owner = declaration.owner

    click_on("Owners")
    expect(page).to have_css(".owner-name", text: "NEW OWNER NAME")
    expect(page).to have_css(".owner-email", text: owner.email)
    expect(page).to have_css(".owner-phone_number", text: owner.phone_number)
    expect(page).to have_css(".owner-nationality", text: owner.nationality)
    expect(page).to have_button("Complete Declaration")

    expect(page).to have_css(".strike", text: registered_owner.name)
    expect(page).to have_css(".strike", text: registered_owner.email)
    expect(page).to have_css(".strike", text: registered_owner.nationality)
    expect(page).to have_css(".strike", text: registered_owner.inline_address)
  end

  scenario "vessel tab" do
    click_on("Vessel Info")
    within("table.submission-vessel") do
      expect(page).to have_css("th", count: 3)
      expect(page)
        .to have_css("td#registry-vessel-name", text: registered_vessel.name)
    end
  end

  scenario "agent tab" do
    click_on("Agent")
    within("table#agent") do
      expect(page)
        .to have_css(
          ".registry-agent-name", text: registered_vessel.agent.name)
    end
  end
end
