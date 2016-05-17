require "rails_helper"

feature "User preregisters for small ships register", type: :feature do
  before do
    visit root_path
    click_on "Start now"
  end

  context "when preregistration is successful" do
    before do
      fill_form_and_submit(
        :preregistration,
        :create,
        check_fields(
          "not_registered_before_on_ssr",
          "not_registered_under_part_1",
          "owners_are_uk_residents",
          "user_eligible_to_register"
        )
      )
    end

    scenario "user is shown a blank page" do
      expect(page.body).to be_empty
    end
  end

  context "when preregistration is not successful" do
    before do
      fill_form_and_submit(
        :preregistration,
        :create,
        check_fields(
          "not_registered_before_on_ssr",
          "owners_are_uk_residents"
        )
      )
    end

    scenario "user is shown preregistration form again" do
      expect(page).to have_text(t("preregistration.new.subtitle"))
    end

    scenario "user is shown preregistration error messages" do
      expect(page).to have_text(error_message("not_registered_under_part_1"))
      expect(page).to have_text(error_message("user_eligible_to_register"))
    end
  end

  def check_fields(*fields)
    fields.map do |field|
      field_key = t("simple_form.labels.preregistration.#{field}")
      [field_key, true]
    end.to_h
  end

  def error_message(field)
    t("activemodel.errors.models.preregistration.attributes.#{field}.accepted")
  end
end
