require "rails_helper"

describe "Read only user" do
  before do
    @submission = create(:completed_submission)
    @vessel = @submission.registered_vessel
    sign_in(create(:read_only_user))
    visit("/")

    click_on("Part 3:")
  end

  scenario "viewing vessels" do
    expect(page).to have_current_path("/vessels")
    expect(page).not_to have_css(".side-menu")

    click_on(@vessel.name.upcase)
    expect(page).not_to have_link("Registrar Tools")
    expect(page).not_to have_link("Add Note")
  end

  scenario "viewing submissions" do
    visit submission_path(@submission)

    expect(page).not_to have_css("#actions")
    expect(page).not_to have_link("Add Correspondence")
    expect(page).not_to have_link("Add Note")
  end
end
