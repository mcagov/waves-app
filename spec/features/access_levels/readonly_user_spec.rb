require "rails_helper"

describe "Read only user" do
  before do
    @vessel = create(:registered_vessel)
    @submission = create(:assigned_submission)

    sign_in(create(:read_only_user))
    visit("/")
  end

  scenario "finance pages" do
    expect(page).not_to have_link("Finance Team")

    visit("/finance/batches")
    expect(page).to have_http_status(401)
  end

  scenario "management reports" do
    expect(page).not_to have_link("Management Reports")

    visit("/admin/reports")
    expect(page).to have_http_status(401)
  end

  scenario "admin tools" do
    click_on("Part 3:")

    visit("/admin/users")
    expect(page).to have_http_status(401)
  end

  scenario "viewing vessels" do
    click_on("Part 3:")
    expect(page).to have_current_path("/vessels")
    expect(page).not_to have_css("#sidebar-menu")

    click_on(@vessel.name.upcase)
    expect(page).not_to have_link("Registrar Tools")
    expect(page).not_to have_link("Add Correspondence")
    expect(page).not_to have_link("Add Note")
  end

  scenario "viewing submissions" do
    click_on("Part 3:")
    visit submission_path(@submission)

    expect(page).not_to have_css("#actions")
    expect(page).not_to have_link("Add Correspondence")
    expect(page).not_to have_link("Add Document")
    expect(page).not_to have_link("Add Note")
  end
end
