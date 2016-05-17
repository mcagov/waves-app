require "rails_helper"

feature "User registers for small ships register", type: :feature do
  before do
    visit root_path
    click_on "Start now"
  end

  context "prerequisites" do
    context "when registration is successful" do
      before do
        fill_form_and_submit(
          :registration,
          :update,
          check_fields(
            "not_registered_before_on_ssr",
            "not_registered_under_part_1",
            "owners_are_uk_residents",
            "user_eligible_to_register"
          )
        )
      end

      scenario "user is taken to next stage" do
        registration_id = Registration.last.id
        expected_path = "/registration_wizard/#{I18n.t('wicked.vessel_info')}?registration_id=#{registration_id}"

        expect(page).to have_current_path(expected_path)
      end
    end

    context "when registration is not successful" do
      before do
        fill_form_and_submit(
          :registration,
          :update,
          check_fields(
            "not_registered_before_on_ssr",
            "owners_are_uk_residents"
          )
        )
      end

      scenario "user is shown registration form again" do
        expect(page).to have_text(t("registration.prerequisites.title"))
      end

      scenario "user is shown registration error messages" do
        expect(page).to have_text(error_message("not_registered_under_part_1"))
        expect(page).to have_text(error_message("user_eligible_to_register"))
      end
    end
  end

  def check_fields(*fields)
    fields.map do |field|
      field_key = t("simple_form.labels.registration.#{field}")
      [field_key, true]
    end.to_h
  end

  def error_message(field)
    t("activerecord.errors.models.registration.attributes.#{field}.accepted")
  end
end
