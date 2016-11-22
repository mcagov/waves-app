require "rails_helper"

feature "User declares a submission", type: :feature, js: true do
  let!(:submission) { create(:incomplete_submission) }
  let!(:bob) { create(:user, name: "Bob") }

  before do
    login_to_part_3(bob)
    visit submission_path(submission)
  end

  scenario "uploading a completed form" do
    click_on("Owners")

    within("#declaration_1 .declaration") do
      expect(page).not_to have_button("Upload Declaration")

      page.attach_file(
        "declaration[completed_form]", mca_file)
      click_on("Upload Declaration")
    end

    click_on("Owners")
    within("#declaration_1 .declaration") do
      expect(page).to have_text("Completed by Bob")
      expect(page).to have_link("mca_test.pdf", href: /mca_test.pdf/)
    end
  end
end
