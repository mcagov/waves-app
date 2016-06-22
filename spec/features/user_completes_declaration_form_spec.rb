require "rails_helper"

feature "User completes declaration form", type: :feature do
  before do
    create_list(:vessel_type, 5)

    session_set_prerequisites
    session_set_vessel_info
    session_set_owner_info

    visit declaration_path
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
      expect(page).to have_text(t("declaration.form.title"))
    end

    scenario "user is shown error messages" do
      expect(page).to have_text(
        error_message(:declaration, "understands_false_statement_is_offence")
      )
    end
  end
end
