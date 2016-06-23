require "rails_helper"

feature "User completes declaration form", type: :feature do
  before do
    clear_cookies!
    create_list(:vessel_type, 5)

    set_prerequisites_cookie
    set_vessel_info_cookie
    set_owner_info_cookie
    set_delivery_address_cookie

    visit declaration_path
  end

  context "when the form is completed successfully" do
    before { complete_declaration_form }

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
