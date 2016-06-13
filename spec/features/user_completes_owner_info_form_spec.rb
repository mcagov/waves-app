require "rails_helper"

feature "User completes owner info form", type: :feature do
  before do
    create_list(:vessel_type, 5)
    visit page_path("start")
    click_on "Start now"

    complete_prerequisites_form
    complete_vessel_info_form
  end

  context "when the form is completed successfully" do
    before do
      complete_owner_info_form
    end

    scenario "user is taken to next stage" do
      expect(page).to have_current_path(path_for_step("declaration"))
    end
  end

  context "when the form is not completed successfully" do
    before do
      invalid_fields = default_owner_info_form_fields.merge(
        first_name: "",
        last_name: "",
        mobile_number: ""
      )
      complete_owner_info_form(invalid_fields)
    end

    scenario "user is shown the form again" do
      expect(page).to have_text(t("registration.owner_info.title"))
    end

    scenario "user is shown error messages" do
      %w(first_name last_name mobile_number).each do |attribute|
        expect(page).to have_text(
          t("activerecord.errors.models.owner.attributes.#{attribute}.blank")
        )
      end
    end
  end
end
