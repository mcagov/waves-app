require "rails_helper"

feature "User declares a submission", type: :feature, js: true do
  let!(:submission) { create_incomplete_submission! }
  let!(:bob) { create(:user, name: "Bob") }

  before do
    login(bob)
    visit submission_path(submission)
  end

  scenario "in its simplest form" do
    click_on("Owners")

    within("#declaration_2 .declaration") do
      click_on("Add manual declaration")
      expect(page).to have_text("Completed by Bob")
    end
  end

  scenario "uploading a completed form" do
    click_on("Owners")

    within("#declaration_2 .declaration") do
      page.attach_file(
        "declaration[completed_form]", "spec/support/files/mca_test.pdf")
      click_on("Add manual declaration")
    end

    click_on("Owners")
    within("#declaration_2 .declaration") do
      expect(page).to have_text("Completed by Bob")
      expect(page).to have_link("mca_test.pdf", href: /mca_test.pdf/)
    end
  end
end
