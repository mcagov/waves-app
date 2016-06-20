require "rails_helper"

feature "User completes declaration form", type: :feature do
  before do
    create_list(:vessel_type, 5)
    visit page_path("start")
    click_on "Start now"

    complete_prerequisites_form
    complete_vessel_info_form
    complete_owner_info_form
  end

  context "when the form is completed successfully" do
    before do
      complete_declaration_form
    end

    scenario "user is taken to next stage" do
      expect(page).to have_current_path(path_for_step("payment"))
    end
  end

  context "when the form is not completed successfully" do
    before do
      complete_declaration_form(
        eligible_under_regulation_89: true,
        eligible_under_regulation_90: true
      )
    end

    scenario "user is shown the form again" do
      expect(page).to have_text(t("registration.declaration.title"))
    end

    scenario "user is shown error messages" do
      expect(page).to have_text(
        error_message("understands_false_statement_is_offence")
      )
    end
  end
end
