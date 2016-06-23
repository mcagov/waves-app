require "rails_helper"

feature "User completes prerequisites form", type: :feature do
  before do
    clear_cookies!

    visit prerequisites_path
  end

  let!(:step) { :prerequisites }

  context "when the form is completed successfully" do
    before do
      complete_prerequisites_form
    end

    scenario "user is taken to next stage" do
      expect(page).to have_current_path(path_for_step("vessel_info"))
    end

    scenario "prerequisites are successfully saved in session" do
      expect_cookie_to_be_set
    end
  end

  context "when the form is not completed successfully" do
    before do
      complete_prerequisites_form(
        not_registered_before_on_ssr: true,
        owners_are_uk_residents: true
      )
    end

    scenario "user is shown the form again" do
      expect(page).to have_text(
        t("prerequisites.form.title")
      )
    end

    scenario "prerequisites are not successfully saved in session" do
      expect_cookie_to_be_unset
    end

    scenario "user is shown error messages" do
      expect(page).to have_text(
        error_message(:prerequisite, "not_registered_under_part_1")
      )
      expect(page).to have_text(
        error_message(:prerequisite, "not_owned_by_company")
      )
      expect(page).to have_text(
        error_message(:prerequisite, "not_commercial_fishing_or_submersible")
      )
      expect(page).to have_text(
        error_message(:prerequisite, "owners_are_eligible_to_register")
      )
      expect(page).to have_text(
        error_message(:prerequisite, "not_registered_on_foreign_registry")
      )
    end
  end
end
